import UIKit

class CompanyListController: UIViewController {
  
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.dataSource = self
      print(CompanyCell.cellIdentifier)
      tableView.register(UINib(nibName: "CompanyCell", bundle: nil), forCellReuseIdentifier: CompanyCell.cellIdentifier)
      tableView.estimatedRowHeight = 66.0
      tableView.rowHeight = UITableViewAutomaticDimension
      tableView.separatorStyle = .none
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
}

extension CompanyListController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let companyCell = tableView.dequeueReusableCell(withIdentifier: CompanyCell.cellIdentifier, for: indexPath)
    return companyCell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
}
