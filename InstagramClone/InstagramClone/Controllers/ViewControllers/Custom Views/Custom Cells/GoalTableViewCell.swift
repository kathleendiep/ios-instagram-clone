//
//  TableViewCell.swift
//  InstagramClone
//
//  Created by Kathleen Diep on 6/16/22.
//

import UIKit

// MARK: - Protocols & Delegates
/*
 /// this is the DUMB file
 - 1. Define Protocol  - This will need to interact with the class level objects and define the task we want our delegate to handle
        /// example code:
         protocol GoalTableViewCellDelegate: AnyObject {
             func toggleSwitchTapped(for cell: GoalTableViewCell)
         }
 - 2. DECLARE the delegate & type
        /// example code:
             // delegate: protocol above
            weak var delegate: GoalTableViewCellDelegate?
    /// this one should be in the other smart file
 
    - 3. Using an extension, confirm to protocol
        - this is in the other * smart * file
    - 4. Assign Delegate
 -5. Tell delegate to perform its function with buttons
    - add this to the outlet
             ///
             @IBAction func completeButtonTapped(_ sender: Any) {
                 // delegate?.nameOfFunctionInProtocol(cell:self)
                 delegate?.goalCellTapped(cell: self)

             }
 */

// STEP 1: Define Protocol
protocol GoalTableViewCellDelegate: AnyObject {
    func goalCellTapped(cell: GoalTableViewCell)
}


class GoalTableViewCell: UITableViewCell {
    // MARK: - Outlet
    @IBOutlet weak var goalInfoLabel: UIButton!
    @IBOutlet weak var goalTitleLabel: UIStackView!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var completeButton2: UIButton!
    
    // MARK: - Actions
    // STEP 5: Tell delegate to PERFORM its function with the button
    @IBAction func completeButtonTapped(_ sender: Any) {
        // delegate?.nameOfFunctionInProtocol(cell:self)
        delegate?.goalCellTapped(cell: self)
    }
    @IBAction func completeButtonTapped2(_ sender: Any) {
        delegate?.goalCellTapped(cell: self)
    }
    // MARK: delegate
    // every cell has to have its own delegate 
    // STEP 2: define it from the procol above
        // delegate: protocol above
    weak var delegate: GoalTableViewCellDelegate?

    // MARK: View functions (update)
    func updateView(with goal: Goal){
        guard let toDoButton = completeButton else {
            return
        }
        
        // Create a string called imageName
        let imageName = goal.isComplete ? "checkmark.square" : "square"
//
//        // Create an image whose name changes depending on whether or not toDo.isDone
        let image = UIImage(systemName: imageName)
//
//        // set the Image to the button
        toDoButton.setImage(image, for: .normal)
        toDoButton.tintColor = goal.isComplete ? UIColor.green : UIColor.gray
    }

}
