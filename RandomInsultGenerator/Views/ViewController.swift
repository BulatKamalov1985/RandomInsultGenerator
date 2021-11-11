//
//  ViewController.swift
//  RandomInsultGenerator
//
//  Created by Bulat Kamalov on 11.11.2021.
//

import UIKit

class ViewController: UIViewController {
    
    var networkManager = NetworkManager.shared
    let storageManager: StorageManagerInterface = StorageManager.shared

    var currentInsult: FuckYouElements? {
        willSet {
            label.text = newValue?.insult
        }
    }

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBAction func getButtonTapped(_ sender: Any) {
        label.text = ""
        
        networkManager.fetchInsult(from: URLS.urlString.rawValue) { [weak self] fuckYouResults in
            self?.currentInsult = fuckYouResults
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        guard let currentInsult = currentInsult else {
            return
        }
        
        storageManager.createEntityFrom(currentInsult)
        storageManager.saveContext()
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        
        getButton.layer.cornerRadius = 12
        getButton.clipsToBounds = true
        
        saveButton.layer.cornerRadius = 12
        saveButton.clipsToBounds = true
        
    }
}

