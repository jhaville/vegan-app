import Foundation
import Firebase

class FirebaseService {
  
  func getItems(of type: ItemType, completion: @escaping ([Item]) -> Void) {
    let db = Firestore.firestore()
    db.collection(type.toCollectionName()).getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        var items = [Item]()
        for document in querySnapshot!.documents {
          print("\(document.documentID) => \(document.data())")
          items.append(Item(name: document.data()["name"] as! String, location: document.data()["location"] as! String, coordinates: Coordinates(longitude: 0, latitude: 0), imageUrls: nil, websiteUrl: nil, itemType: type))
        }
        completion(items)
      }
    }

  }
}
