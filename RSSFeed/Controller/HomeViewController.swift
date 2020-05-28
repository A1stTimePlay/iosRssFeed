import UIKit
import CoreData

class HomeViewController: UITableViewController, XMLParserDelegate {
    
    private var rssItems: [RssItem]?
    private let coreDataService = CoreDataService()
    var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData(url: url)
    }
    
    private func fetchData(url: String?){
        let feedParser = MXMLParser()
        let parsedUrl = url ?? "https://developer.apple.com/news/rss/news.rss"
        feedParser.parseFeed(url: parsedUrl) { (rssItems) in
            self.rssItems = rssItems
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }

    // MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let rssItems = rssItems else {
            return 0
        }
        
        return rssItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCell", for: indexPath) as UITableViewCell
        
        if let item = rssItems?[indexPath.item] {
            cell.textLabel?.text = item.title
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = rssItems![indexPath.row] as RssItem
        let webViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idTutorialViewController") as! WebViewController
        webViewController.tutorialUrl = URL(string: selected.link)
        showDetailViewController(webViewController, sender: self)
    }
    
    // MARK: Action

    @IBAction func addRssLink(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New RSS Feed", message: "", preferredStyle: .alert)
        
        alert.addTextField()
        alert.textFields![0].placeholder = "RSS Name"
        
        alert.addTextField()
        alert.textFields![1].placeholder = "RSS URL"
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        alert.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default) { action in
            guard let tfName = alert.textFields?[0], let feedName = tfName.text else {
                return
            }
            guard let tfUrl = alert.textFields?[1], let feedUrl = tfUrl.text else {
                return
            }
            self.coreDataService.saveData(name: feedName, url: feedUrl)
        }
        alert.addAction(saveAction)
        
        self.present(alert, animated: true)
        
    }
    
    @IBAction func showBookmark(_ sender: UIBarButtonItem) {
    }
}
