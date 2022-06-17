//
//  File.swift
//  InstagramClone
//
//  Created by Kathleen Diep on 6/16/22.
//

import Foundation
import UIKit

class Goal: Codable {
    var title: String
    var notes: String?
    var isComplete: Bool
    
    init(title: String, notes: String?, isComplete: Bool = false){
        self.title = title
        self.notes = notes
        self.isComplete = isComplete
    }
}

//MARK: - Extension
// conforms our Task to Equatable so we can compare two instances of Task to determine whether they are the same Task.  Checks all properties of the tasks and returns true only if all properties are the same.
extension Goal: Equatable {
    static func == (lhs: Goal, rhs: Goal) -> Bool {
        return lhs.title == rhs.title && lhs.notes == rhs.notes
        && lhs.isComplete == rhs.isComplete
    }
}

