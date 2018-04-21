import Foundation

struct ItemsViewModel {
  let itemViewModels: [ItemViewModel]
}

extension ItemsViewModel {
  init(with items: [Item]) {
    self.init(itemViewModels: items.map(ItemViewModel.init))
  }
}

struct ItemViewModel {
  let name: String
  let location: String
  let distanceDescription: String
  let imageUrls: [URL]?
}

extension ItemViewModel {
  init(with item: Item) {
    let distanceFromUser = "3"
    self.init(name: item.name, location: item.location, distanceDescription: distanceFromUser + " miles away", imageUrls: item.imageUrls)
  }
}

