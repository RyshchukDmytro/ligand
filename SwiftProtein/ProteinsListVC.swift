//
//  ProteinsListVC.swift
//  SwiftProtein
//
//  Created by Dmytro Ryshchuk on 10/12/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import UIKit

class ProteinsListVC: UIViewController {

    // MARK: - outlets
    @IBOutlet weak var proteinsSearchBar: UISearchBar!
    @IBOutlet weak var proteinsTableView: UITableView!
    
    // MARK: - properties
    private var moleculs = [String]()
    private var filteredMoleculs = [String]()
    
    // MARK: - ViewCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Proteins"
        readFromLigandFile()
    }
    
    // MARK: - functions
    private func readFromLigandFile() {
        let path = Bundle.main.path(forResource: "ligands", ofType: "txt")
        do {
            let text = try String(contentsOfFile: path!, encoding: .utf8)
            for line in text.split(separator: "\n") {
                moleculs.append(String(line))
            }
            filteredMoleculs = moleculs
        } catch {
            print(error)
        }
    }
}

// MARK: - TableView extension
extension ProteinsListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMoleculs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! ProteinTVC
        cell.proteinName.text = filteredMoleculs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        proteinsTableView.deselectRow(at: indexPath, animated: true)
        let api = Api()
        api.getProteinFullDescription(name: filteredMoleculs[indexPath.row])
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProteinDetailsVC") as! ProteinDetailsVC
        //        storyboard.checkin = checkin
        //        self.navigationController?.pushViewController(storyboard, animated: true)
    }
}

// MARK: - SearchBar extension
extension ProteinsListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredMoleculs = searchText.isEmpty ? moleculs : moleculs.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        proteinsTableView.reloadData()
    }
}
