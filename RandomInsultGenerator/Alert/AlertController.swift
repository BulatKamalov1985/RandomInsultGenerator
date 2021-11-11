//
//  AlertController.swift
//  RandomInsultGenerator
//
//  Created by Bulat Kamalov on 11.11.2021.
//

import UIKit

class AlertController: UIAlertController {

    func action(insult: InsultData?, completion: @escaping (String) -> Void) {
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Insult"
            textField.text = insult?.title
        }
    }

}
