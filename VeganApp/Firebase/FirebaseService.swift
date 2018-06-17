import Foundation
import Firebase

protocol FirebaseService {
  func getItems(of type: ItemType, completion: @escaping (Error?, [Item]) -> Void)
}

class FirebaseServiceImpl {
//  let db = Firestore.firestore()

//  func getItems(of type: ItemType, completion: @escaping (Error?, [Item]?) -> Void) {
//    db.collection(type.toCollectionName()).getDocuments() { querySnapshot, error in
//      if let error = error {
//        completion(error, nil)
//      } else {
//        let items = querySnapshot?.documents.flatMap({ document -> Item? in
//          let data = document.data()
//          guard let name = data["name"] as? String, let location = data["location"] as? String else { return nil }
//            let imageURLs = data["imageUrls"] as? [String]
//            let coordinates = data["coordinates"] as? GeoPoint
//            return Item(name: name, location: location, coordinates: coordinates, imageUrls: imageURLs?.map { URL(string: $0)! }, websiteUrl: nil, itemType: type)
//        })
//        completion(nil, items)
//      }
//    }

//  }
}
