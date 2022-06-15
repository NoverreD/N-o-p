//
//  MainTableViewController.swift
//  Nop
//
//  Created by dengzhihao on 2021/10/22.
//

import UIKit

class MainTableViewController: UITableViewController {

    var dataSource: [UIViewController.Type] = [
        EventViewController.self,
        LabelContainerViewController.self,
        ShadowViewController.self,
        LazySequenceViewController.self,
        StringRaceViewController.self,
        FontViewController.self,
        FontLeadingViewController.self,
        TransitionViewController.self,
        LayoutGuideViewController.self,
        SDWebImageViewController.self,
        ConcurrentViewController.self,
        LabelImageViewController.self,
        TextViewViewController.self,
        SDWebImageViewController.self,
        CollectionViewViewController.self,
        LabelScaleViewController.self,
        TableViewController.self,
        IntrinsicContentSizeViewController.self,
        FileManagerViewController.self,
        GifImageViewController.self,
        ScrollViewConvertRectViewController.self,
        PropertyWrapperViewController.self,
        Box2ViewController.self,
        TempViewController.self,
        CVCellSizeViewController.self,
        ScrollViewDidScrollViewController.self,
        ARCViewController.self
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataSource.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        if let temp = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") {
            cell = temp
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
        }
        
        cell.textLabel?.text = dataSource[indexPath.row].description()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = (dataSource[indexPath.row]).init()
        vc.view.backgroundColor = UIColor.white
        show(vc, sender: nil)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}