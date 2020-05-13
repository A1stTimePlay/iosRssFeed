import UIKit

class TopicsTableViewController: UITableViewController, XMLParserDelegate {
    
    private var rssItems: [RssItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
    }
    
    private func fetchData(){
        let feedParser = MXMLParser()
        feedParser.parseFeed(url: "https://developer.apple.com/news/rss/news.rss") { (rssItems) in
            self.rssItems = rssItems
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }

    // MARK: - Table view data source

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
        let tutorialViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "idTutorialViewController") as! TutorialViewController
        tutorialViewController.tutorialUrl = URL(string: selected.link)
        showDetailViewController(tutorialViewController, sender: self)
    }

}
