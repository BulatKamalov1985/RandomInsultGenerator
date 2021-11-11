//
//  InsultsTableVC.swift
//  RandomInsultGenerator
//
//  Created by Bulat Kamalov on 11.11.2021.
//

import UIKit

class InsultsTableVC: UITableViewController {

    
    private let cellID = "Сell"
    private var insults: [InsultData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let insults = StorageManager.shared.fetchInsults() else { return }
        self.insults = insults
        setupNavigationBar()
    }
    
    
    @IBAction func shareTapped(_ sender: UIBarButtonItem) {
        let items: [Any] = ["Text for Share"]
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewInsult)
        )
    }
    
    @objc private func addNewInsult() {
        showAlert()
    }
    
    private func save(insult: String) {
        StorageManager.shared.save(insult) { insult in
            self.insults.append(insult)
            self.tableView.insertRows(
                at: [IndexPath(row: self.insults.count - 1, section: 0)],
                with: .automatic
            )
        }
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return insults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = insults[indexPath.row].title

        return cell
    }
}

// MARK: - Alert Controller

extension InsultsTableVC {
    
    private func showAlert(insult: InsultData? = nil, completion: (() -> Void)? = nil) {
        
        let title = insult != nil ? "Update insult" : "New insult"
        
        let alert = AlertController(
            title: title,
            message: "What do you want to do?",
            preferredStyle: .alert
        )
        
        alert.action(insult: insult) { insultName in
            if let insult = insult, let completion = completion {
                StorageManager.shared.edit(insult, newname: insultName)
                completion()
            } else {
                self.save(insult: insultName)
            }
        }
        
        present(alert, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension InsultsTableVC {
    
    // Edit task
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let insult = insults[indexPath.row]
        showAlert(insult: insult) {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Delete task
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let insult = insults[indexPath.row]
        
        if editingStyle == .delete {
            insults.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.delete(insult)
        }
    }
}
