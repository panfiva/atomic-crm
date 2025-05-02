import { Store } from './types';

// cloned from react-admin v4.15.0

type Subscription = {
    key: string;
    callback: (value: any) => void;
};

function tryParse(value: string) {
    try {
        return JSON.parse(value);
    } catch (e) {
        return value;
    }
}

class LocalStorageShim {
    valuesMap: any = new Map<string, string>();

    getItem(key: string) {
        if (this.valuesMap.has(key)) {
            return String(this.valuesMap.get(key));
        }
        return null;
    }

    setItem(key: string, value: string) {
        this.valuesMap.set(key, value);
    }

    removeItem(key: string) {
        this.valuesMap.delete(key);
    }

    removeItems(keyPrefix: string) {
        this.valuesMap.forEach((_value: string, key: string) => {
            if (key.startsWith(keyPrefix)) {
                this.valuesMap.delete(key);
            }
        });
    }

    clear() {
        this.valuesMap.clear();
    }

    key(i: number): string {
        if (arguments.length === 0) {
            throw new TypeError(
                "Failed to execute 'key' on 'Storage': 1 argument required, but only 0 present."
            ); // this is a TypeError implemented on Chrome, Firefox throws Not enough arguments to Storage.key.
        }
        const arr = Array.from(this.valuesMap.keys()) as string[];
        return arr[i];
    }

    get length() {
        return this.valuesMap.size;
    }
}

const memoryStorage = new LocalStorageShim();

/**
 * Store using localStorage, sessionStorage, or memory storage
 * Will default to memory storage if requested storage type is not available (e.g. incognito mode)
 */
export const storeFactory = (props: {
    storage_type: 'localStorage' | 'sessionStorage' | 'memory';
    store_name: string;
}) => {
    const { storage_type, store_name } = props;

    // localStorage isn't available in incognito mode. We need to detect it
    const testLocalStorage = () => {
        if (storage_type === 'memory') return false;

        if (
            typeof window === 'undefined' ||
            window[storage_type] == undefined
        ) {
            return false;
        }

        try {
            window[storage_type].setItem('test', 'test');
            window[storage_type].removeItem('test');
            return true;
        } catch (e) {
            return false;
        }
    };

    const localStorageAvailable = testLocalStorage();

    function getStorage() {
        if (props.storage_type === 'memory') {
            return memoryStorage;
        }

        return localStorageAvailable
            ? window[props.storage_type]
            : memoryStorage;
    }

    return (version: string, app_key?: string): Store => {
        /** contains <store_name>.<app_key> */
        const prefix: string = [store_name, app_key].filter(v => !!v).join('.');
        const prefixLength = prefix.length;
        const subscriptions: { [key: string]: Subscription } = {};
        const publish = (key: string, value: any) => {
            Object.keys(subscriptions).forEach(id => {
                if (!subscriptions[id]) return; // may happen if a component unmounts after a first subscriber was notified
                if (subscriptions[id].key === key) {
                    subscriptions[id].callback(value);
                }
            });
        };

        // Whenever the local storage changes in another document, look for matching subscribers.
        // This allows to synchronize state across tabs
        const onLocalStorageChange = (event: StorageEvent): void => {
            if (event.key?.substring(0, prefixLength) !== prefix) {
                return;
            }
            const key = event.key.substring(prefixLength + 1);
            const value = event.newValue ? tryParse(event.newValue) : undefined;
            Object.keys(subscriptions).forEach(id => {
                if (!subscriptions[id]) return; // may happen if a component unmounts after a first subscriber was notified
                if (subscriptions[id].key === key) {
                    if (value === null) {
                        // an event with a null value is sent when the key is deleted.
                        // to enable default value, we need to call setValue(undefined) instead of setValue(null)
                        subscriptions[id].callback(undefined);
                    } else {
                        subscriptions[id].callback(
                            value == null ? undefined : value
                        );
                    }
                }
            });
        };

        return {
            setup: () => {
                if (localStorageAvailable) {
                    const storedVersion = getStorage().getItem(
                        `${prefix}.version`
                    );
                    if (storedVersion && storedVersion !== version) {
                        const storage = getStorage();
                        Object.keys(storage).forEach(key => {
                            if (key.startsWith(prefix)) {
                                storage.removeItem(key);
                            }
                        });
                    }
                    getStorage().setItem(`${prefix}.version`, version);
                    window.addEventListener('storage', onLocalStorageChange);
                }
            },
            teardown: () => {
                if (localStorageAvailable) {
                    window.removeEventListener('storage', onLocalStorageChange);
                }
            },
            getItem<T = any>(key: string, defaultValue?: T): T {
                const valueFromStorage = getStorage().getItem(
                    `${prefix}.${key}`
                );

                return valueFromStorage == null
                    ? (defaultValue as any)
                    : tryParse(valueFromStorage);
            },
            setItem<T = any>(key: string, value: T): void {
                if (value === undefined) {
                    getStorage().removeItem(`${prefix}.${key}`);
                } else {
                    getStorage().setItem(
                        `${prefix}.${key}`,
                        JSON.stringify(value)
                    );
                }
                publish(key, value);
            },
            removeItem(key: string): void {
                getStorage().removeItem(`${prefix}.${key}`);
                publish(key, undefined);
            },
            removeItems(keyPrefix: string): void {
                const storage = getStorage();
                Object.keys(storage).forEach(key => {
                    if (key.startsWith(`${prefix}.${keyPrefix}`)) {
                        storage.removeItem(key);
                        const publishKey = key.substring(prefixLength + 1);
                        publish(publishKey, undefined);
                    }
                });
            },
            reset(): void {
                const storage = getStorage();
                Object.keys(storage).forEach(key => {
                    if (key.startsWith(prefix)) {
                        storage.removeItem(key);
                        const publishKey = key.substring(prefixLength + 1);
                        publish(publishKey, undefined);
                    }
                });
            },
            subscribe: (key: string, callback: (value: string) => void) => {
                let id = Math.random().toString();
                while (subscriptions[id]) {
                    id = Math.random().toString();
                }

                subscriptions[id] = {
                    key,
                    callback,
                };
                return () => {
                    delete subscriptions[id];
                };
            },
        };
    };
};
