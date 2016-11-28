//
//  FrankenTableViewController.swift
//  Frankentable
//
//  Created by Jason Gresh on 11/26/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

class FrankenTableViewController: UITableViewController {

    @IBOutlet weak var switchBarButton: UIBarButtonItem!
    var dictionary = [String: Int]()
    var tableData = [String]()
    private var switchIndicator = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        loadTableData()
    }

    func loadData(){
        if let url = Bundle.main.url(forResource: "Data", withExtension: "txt"),
            let data = try? Data(contentsOf: url),
            let text = String(data: data, encoding: .utf8) {
            
            var rawDict = [String: Int]()
            for word in text.lowercased().components(separatedBy: CharacterSet.whitespacesAndNewlines.union(CharacterSet.punctuationCharacters)) where word != " "{
                if word != ""{
                    rawDict[word] = (rawDict[word] ?? 0) + 1
                }
            }
            self.dictionary = rawDict
        }
    }
    
    func loadTableData(){
        self.tableData.removeAll()
        switch self.switchIndicator{
        case 0:
            for (key, value) in self.dictionary.sorted(by: { $0.1 > $1.1 }){
                self.tableData.append("\(key) (\(value))")
            }
        case 1:
            for (key, value) in self.dictionary.sorted(by: { $0.0 < $1.0 }){
                self.tableData.append("\(key) (\(value))")
            }
        default:
            print("Issuse pop out here.")
        }
    }

    @IBAction func switchTapped(_ sender: UIBarButtonItem) {
        if self.switchIndicator == 0{
            self.switchIndicator = 1
        }else{
            self.switchIndicator = 0
        }
        print(self.switchIndicator)
        loadTableData()

        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dictionary.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = self.tableData[indexPath.row]

        return cell
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
