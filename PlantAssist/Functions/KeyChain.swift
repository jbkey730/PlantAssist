//
//  SaveCreds.swift
//  PlantAssist
//
//  Created by Jacob Lamkey on 6/17/22.
//

import Foundation
import Security


class KeyChain {
    struct User {
        let identifier: Int64
        let password: String
    }

    private static let service = "MyService"

    static func save(user: User) -> Bool {
        let identifier = Data(from: user.identifier)
        let password = user.password.data(using: .utf8)!
        let query = [kSecClass as String : kSecClassGenericPassword as String,
                     kSecAttrService as String : service,
                     kSecAttrAccount as String : identifier,
                     kSecValueData as String : password]
            as [String : Any]

        let deleteStatus = SecItemDelete(query as CFDictionary)

        if deleteStatus == noErr || deleteStatus == errSecItemNotFound {
            return SecItemAdd(query as CFDictionary, nil) == noErr
        }

        return false
    }

    static func retrieveUser() -> User? {
        let query = [kSecClass as String : kSecClassGenericPassword,
                     kSecAttrService as String : service,
                     kSecReturnAttributes as String : kCFBooleanTrue!,
                     kSecReturnData as String: kCFBooleanTrue!]
            as [String : Any]

        var result: AnyObject? = nil
        let status = SecItemCopyMatching(query as CFDictionary, &result)

        if status == noErr,
            let dict = result as? [String: Any],
            let passwordData = dict[String(kSecValueData)] as? Data,
            let password = String(data: passwordData, encoding: .utf8),
            let identifier = (dict[String(kSecAttrAccount)] as? Data)?.to(type: Int64.self) {

            return User(identifier: identifier, password: password)
        } else {
            return nil
        }
    }
}

private extension Data {
    init<T>(from value: T) {
        var value = value

        self.init(buffer: UnsafeBufferPointer(start: &value, count: 1))
    }

    func to<T>(type: T.Type) -> T {
        withUnsafeBytes { $0.load(as: T.self) }
    }
}
//extension Data {
//
//    init<T>(from value: T) {
//        var value = value
//            var myData = Data()
//            withUnsafePointer(to:&value, { (ptr: UnsafePointer<T>) -> Void in
//                myData = Data( buffer: UnsafeBufferPointer(start: ptr, count: 1))
//            })
//            self.init(myData)
//    }
//
//    func to<T>(type: T.Type) -> T {
//        return self.withUnsafeBytes { $0.load(as: T.self) }
//    }
//}
