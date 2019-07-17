//
//  TableViewController.swift
//  TableViewExample
//
//  Created by mac on 7/9/19.
//  Copyright © 2019 WayneEnterprise. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var name = [HeroName]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        createHero()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }

    private func createHero()
    {
        let hero_1 = HeroName(RealName: "Bruce Wayne", HeroName: "Batman")
        let hero_2 = HeroName(RealName: "Clark Kent", HeroName: "Superman")
        name += [hero_1, hero_2]
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? TableViewCell
        else
        {
            fatalError("The dequeued cell is not an instance of Cell.")
        }

        // Configure the cell..
        let hero = name[indexPath.row]
        cell.mName.text = hero.heroName
        cell.mIdentity.text = hero.secretIdentity

        return cell
    }
 
    @IBAction func unwindToMyHero(sender: UIStoryboardSegue)
    {
        if let sourceViewController = sender.source as? ViewController, let hero = sourceViewController.hero
        {
            let index = IndexPath(row: name.count, section: 0)
            name.append(hero)
            tableView.insertRows(at: [index], with: .automatic)
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
