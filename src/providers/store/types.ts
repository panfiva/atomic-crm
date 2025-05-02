// cloned from react-admin v4.15.0
export interface Store {
    setup: () => void;
    teardown: () => void;
    getItem: <T = any>(key: GlobalStoreKeys, defaultValue?: T) => T;
    setItem: <T = any>(key: GlobalStoreKeys, value: T) => void;
    removeItem: (key: GlobalStoreKeys) => void;
    removeItems: (keyPrefix: string) => void;
    reset: () => void;
    subscribe: (
        key: GlobalStoreKeys,
        callback: (value: any) => void
    ) => () => void;
}

export type GlobalStoreKeys = string;
