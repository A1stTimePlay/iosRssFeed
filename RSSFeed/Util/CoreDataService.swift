import CoreData

import UIKit

class CoreDataService: NSObject {
    
    // Take care of Core Data operation
    
    private var rssFeeds: [NSManagedObject] = []
    
    func loadData() -> [NSManagedObject] {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return rssFeeds
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedRssFeed")
        
        do {
            rssFeeds = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return rssFeeds
    }
    
    func saveData(name: String, url: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "SavedRssFeed", in: managedContext)!
        
        let rssFeed = NSManagedObject(entity: entity, insertInto: managedContext)
        
        rssFeed.setValue(name, forKeyPath: "name")
        rssFeed.setValue(url, forKey: "url")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}
