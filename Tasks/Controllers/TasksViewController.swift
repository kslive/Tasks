//
//  TasksViewController.swift
//  Tasks
//
//  Created by Eugene Kiselev on 25.08.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import UIKit
import Firebase

class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
    }
    
        @IBAction func signOut(_ sender: UIBarButtonItem) {
            
            do {
                try Auth.auth().signOut()
            } catch {
                print(error.localizedDescription)
            }
            
            dismiss(animated: true, completion: nil)
        }
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        
        cell.backgroundColor = .clear
        
        return cell
    }
}
