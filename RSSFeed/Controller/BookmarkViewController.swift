import UIKit
import CoreData

class BookmarkViewController: UITableViewController {
    
    private var rssFeeds: [NSManagedObject]?
    private let coreDataService = CoreDataService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rssFeeds = coreDataService.loadData()
    }
    
    // MARK: Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let rssFeeds = rssFeeds else {
            return 0
        }
        
        return rssFeeds.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idBookmarkCell", for: indexPath) as UITableViewCell
        
        if let feed = rssFeeds?[indexPath.item] {
            cell.textLabel?.text = feed.value(forKeyPath: "name") as? String
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hello world")
    }
}
