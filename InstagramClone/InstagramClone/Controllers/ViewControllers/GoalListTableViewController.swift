//
//  GoalListTableViewController.swift
//  InstagramClone
//
//  Created by Kathleen Diep on 6/16/22.
//

import UIKit

class GoalListTableViewController: UITableViewController {
    
    // MARK: Lifecycle Methods
    //   When the view gets loaded into memory, load any Tasks we have in our data store.
    override func viewDidLoad() {
        super.viewDidLoad()
        GoalController.shared.loadFromPersistenceStore()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: Actions
    // ALERT
        // save, cancel
        // this is for add button to make a new one
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "What do you need to do?", message: "Write something you need ToDo", preferredStyle: .alert)
        
        alert.addTextField()
        
        let saveButton = UIAlertAction(title:"Save", style: .default) { _ in
            if let title = alert.textFields?.first?.text {
                GoalController.shared.createGoal(title: title, notes: nil)
                self.tableView.reloadData()
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        
        present(alert,animated: true)
    }
    
    
    // MARK: - Table view data source
    // number of rows based on the count in array
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GoalController.shared.goals.count
    }
    
    // reuse identifier
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cast our cell as our custom CELL
        let cell = tableView.dequeueReusableCell(withIdentifier: "goalTitle", for: indexPath) as! GoalTableViewCell
        
        // Step 4: Assign the delegate
        cell.delegate = self
        // cell.goalTitleLabel = GoalController.shared.goals[indexPath.row].title
        
        return cell
    }
}
// STEP 3:
// add extension for Protocol
extension GoalListTableViewController: GoalTableViewCellDelegate {
    func goalCellTapped(cell: GoalTableViewCell) {
        // find your index path
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        // find your setting - CHANGE THE SHARED INSTANCE HERE
        let goal = GoalController.shared.goals[indexPath.row]
        
        // update your setting
        GoalController.shared.toggleIsComplete(goal: goal)
        cell.updateView(with: goal)
    }
}


