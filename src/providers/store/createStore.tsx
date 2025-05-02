import { storeFactory } from './storeFactory';
import { Store } from './types';

/**
 * returns a store that stores selected attributes in memory istead of a local_storage
 *
 * Store version can be used to invalidate the local storage for all users
 */
export function createStore(props: {
    store_version: string;

    app_key?: string;
    /** defaults to `CRM` */
    store_name?: string;
}): Store {
    const { store_version, app_key, store_name = 'CRM' } = props;

    const local = storeFactory({
        storage_type: 'localStorage',
        store_name,
    })(store_version, app_key);

    const memory = storeFactory({
        storage_type: 'memory',
        store_name,
    })(store_version, app_key);

    const session = storeFactory({
        storage_type: 'sessionStorage',
        store_name,
    })(store_version, app_key);

    /** store key name endings that should be included in non-persistent storage */

    const storeEndsWith: Record<string, Store> = {
        '.listParams': session,
        '.selectedIds': session,
        '.selectedIds.pathname': session,
        'ra.inspector.position': session,
        '.datagrid.expanded': session,
    };

    function getStore(k: string): Store {
        // Iterate over the keys of storeEndsWith
        for (const key in storeEndsWith) {
            if (k.endsWith(key)) {
                return storeEndsWith[key]; // Return the matching store
            }
        }

        return local;
    }

    const store: Store = {
        // prettier-ignore
        setup: () => {local.setup(); memory.setup(); session.setup();},
        // prettier-ignore
        teardown: () => {session.teardown(); memory.teardown();session.teardown()},
        // prettier-ignore
        getItem <T = any>(key: string, defaultValue?: T):T{return getStore(key).getItem(key, defaultValue) },
        // prettier-ignore
        setItem <T = any>(key: string, value: T){return getStore(key).setItem(key, value)},
        // prettier-ignore
        removeItem: (key: string) => {getStore(key).removeItem(key)},
        // prettier-ignore
        removeItems: (keyPrefix) => {local.removeItems(keyPrefix); memory.removeItems(keyPrefix);session.removeItems(keyPrefix)},
        // prettier-ignore
        reset: ()=>{local.reset(); memory.reset(); session.reset()},
        // prettier-ignore
        subscribe: (key, callback) => getStore(key).subscribe(key, callback),
    } as Store;

    return store;
}
