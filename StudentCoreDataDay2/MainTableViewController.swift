//
//  MainTableViewController.swift
//  StudentCoreDataDay2
//
//  Created by Lin Wei on 2/10/16.
//  Copyright © 2016 Lin Wei. All rights reserved.
//

import UIKit
// step 1
import CoreData
class MainTableViewController: UITableViewController {
   
//step 2 array of  Student which is an [manageObject]
    
    var students = [Student]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // create fetch initial data
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        //create fetchRequest 
        
        let fetchRequest = NSFetchRequest(entityName: "Student")
        
        let error: NSError?
        
        do {
            
            try students = managedObjectContext.executeFetchRequest(fetchRequest) as! [Student]
        }
        catch let error1 as NSError {
            
            error = error1
            if error != nil {
                print(" failed to load")
            }
        }
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    func saveStudent(name:String){
        let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let student = NSEntityDescription.insertNewObjectForEntityForName("Student", inManagedObjectContext: managedObjectContext) as! Student
        
        student.setValue(name, forKey: "name")
        
        let err: NSError?
        do {
            
            try managedObjectContext.save()
             students.append(student)
        } catch let error1 as NSError {
            
            err = error1
            if err != nil {
                print("error failed to save")
            }
        }
        
    }
    
    @IBAction func AddButtonOnClick(sender: UIBarButtonItem) {
        
        let alertViewController = UIAlertController(title: "Add Student", message: "create a new student", preferredStyle: .Alert)
        
        let addAlertAction =  UIAlertAction(title: "add", style: .Default) { (alertAction:UIAlertAction) -> Void in
            
            let textField =  alertViewController.textFields![0] as UITextField
            
            self.saveStudent(textField.text!)
            
            self.tableView.reloadData()
            
        }
        
        let cancelAlertAction =  UIAlertAction(title: "cancel", style: .Cancel) { (action:UIAlertAction) -> Void in
            
        }
        
        alertViewController.addTextFieldWithConfigurationHandler { (textField:UITextField) -> Void in
            
        }
        
        alertViewController.addAction(addAlertAction)
        alertViewController.addAction(cancelAlertAction)
        
        
        presentViewController(alertViewController, animated: true, completion: nil)
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)

        //step 3
        cell.textLabel?.text = students[indexPath.row].name
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
