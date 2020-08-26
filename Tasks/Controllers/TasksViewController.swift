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
    
    var user: Users!
    var ref: DatabaseReference!
    var tasks = [Task]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setObserver()
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {

        let alert = UIAlertController(title: "New Task", message: "Add new task", preferredStyle: .alert)
        alert.addTextField()
        
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            
            guard let textField = alert.textFields?.first, textField.text != nil else { return }
            
            let task = Task(title: textField.text!, userID: (self?.user.uid)!)
            let taskRef = self?.ref.child(task.title.lowercased())
            taskRef?.setValue(["title": task.title, "userId": task.userID, "completed": task.completed])
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(save)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Help Function
    
    func createUser() {
        
        guard let currentUser = Auth.auth().currentUser else { return }
        
        user = Users(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }
    
    func setObserver() {
        
        ref.observe(.value) { [weak self] snapshot in
            
            var _tasks = [Task]()
            
            for item in snapshot.children {
                
                let task = Task(snapshot: item as! DataSnapshot)
                _tasks.append(task)
            }
            
            self?.tasks = _tasks
            self?.tableView.reloadData()
        }
    }
}

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        let taskTitle = tasks[indexPath.row].title
        
        cell.backgroundColor = .clear
        cell.textLabel?.text = taskTitle
        
        
        return cell
    }
}
