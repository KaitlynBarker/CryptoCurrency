//
//  PopularCurrencyListTableViewController.swift
//  CryptoCurrency
//
//  Created by Kaitlyn Barker on 6/15/18.
//  Copyright © 2018 Kaitlyn Barker. All rights reserved.
//

import UIKit

class PopularCurrencyListTableViewController: UITableViewController {
    
    var currencyData: [Datum] = []
    
    // MARK: - Outlets
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.shared.getPopularCurrencyInfo { (response) in
            guard let response = response else { return }
            
            DispatchQueue.main.async {
                self.currencyData = response.data
                self.tableView.reloadData()
            }
        }
        
    }
    
    // MARK: - Actions
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencyData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath) as? PopularCurrencyTableViewCell else { return UITableViewCell() }

        let currencyData = self.currencyData[indexPath.row]
        
        cell.currencyData = currencyData

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

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCurrencyDetailSB" {
            guard let destinationVC = segue.destination as? CurrencyDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let currencyData = self.currencyData[indexPath.row]
            
            destinationVC.currencyData = currencyData
        }
    }
}
