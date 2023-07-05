import UIKit

var greeting = "Hello, playground"

let array = {"123";[ 1, 2 ]}

func json(from object:Any) -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
        return nil
    }
    return String(data: data, encoding: String.Encoding.utf8)
}

print("\(json(from:array as Any) ?? "")")
