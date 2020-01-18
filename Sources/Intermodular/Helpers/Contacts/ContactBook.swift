//
// Copyright (c) Vatsal Manot
//

#if canImport(Contacts)

import Contacts

public class ContactBook {
    private static let store = CNContactStore()
    
    public class func fetchAll(keysToFetch: [CNKeyDescriptor]) throws -> [CNContact] {
        return try store.containers(matching: nil).flatMap { container in
            try store.unifiedContacts(
                matching: CNContact.predicateForContactsInContainer(
                    withIdentifier: container.identifier
                ),
                keysToFetch: keysToFetch
            )
        }
    }
}

#endif
