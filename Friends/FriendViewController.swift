//
//  ViewController.swift
//  Friends
//
//  Created by Philip on 9/15/16.
//  Copyright © 2016 Philip Vo. All rights reserved.
//

import UIKit
import CoreData

class FriendViewController: UITableViewController, AddViewControllerDelegate, CancelButtonDelegate {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var friends = [Friend]()
    
    func fetch() {
        let userRequest = NSFetchRequest(entityName: "Friend")
        
        do {
            let results = try managedObjectContext.executeFetchRequest(userRequest)
            friends = results as! [Friend]
        } catch {
            print("\(error)")
        }
    }

    func save() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                print("\(error)")
            }
        }
    }
    
    // TABLE VIEW
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender is UITableViewCell {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ShowViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.friend = friends[indexPath.row]
            }
        } else {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FriendCell") as! FriendCell
//        cell.imgView = friends[indexPath.row].img
        cell.nameLabel.text = friends[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        managedObjectContext.deleteObject(friends[indexPath.row])
        save()
        fetch()
        tableView.reloadData()
    }
    
    // FRIEND TABLE VIEW
    func addViewController(controller: AddViewController, didFinishAddingFriend friend: [String]) {
        dismissViewControllerAnimated(true, completion: nil)
        print("In friendview")
        var new_friend = NSEntityDescription.insertNewObjectForEntityForName("Friend", inManagedObjectContext: managedObjectContext) as! Friend
        new_friend.imgurl = "NA"
        new_friend.name = friend[0]
        new_friend.desc = friend[1]
        save()
        fetch()
        tableView.reloadData()
    }
    
    func addViewController(controller: AddViewController, didFinishEditingFriend friend: Friend) {
        dismissViewControllerAnimated(true, completion: nil)
        save()
        fetch()
        tableView.reloadData()
    }
    
    // CANCEL
    func cancelButtonPressedFrom(controller: UITableViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        fetch()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

