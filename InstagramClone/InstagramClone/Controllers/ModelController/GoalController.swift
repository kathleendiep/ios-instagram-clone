//
//  GoalController.swift
//  InstagramClone
//
//  Created by Kathleen Diep on 6/16/22.
//

import Foundation

class GoalController {
    // MARK: - Properties
    // shared inference to be passed throughout file
        // ex: refers to static.sourceoftruth in the ViewControllers
    static let shared = GoalController()
    
    // MARK: - Source of Truth
    // to make crud possible
    var goals: [Goal] = []
    
    // MARK: - CRUD
    // CREATE
    /**
       This function creates a SOT
        - Parameters: define
        - Create a new instance of Class
                - Class(property: type)
        - add to the SOT
            - append
     */
    func createGoal( title: String, notes: String? ){
        let newGoal = Goal( title:title, notes: notes)
        goals.append(newGoal)
        saveToPersistenceStore()
    }
    
    // DELETE
        /*
         Finds the item you want to delete
         - guard let
         - if all conditions pass, then delete
         - find index of Class
            - array.remove(at: index)
         */
    func deleteGoal( goal: Goal){
        guard let index = goals.firstIndex(of:goal) else { return }
        goals.remove(at: index)
        print("Successfully deleted: \(goal.title)")
        saveToPersistenceStore()
    }
    // UPDATE
        /*
         Which Class will be updated
         */
    func updateGoal(goal: Goal, title: String, notes: String? ){
        goal.title = title
        goal.notes = notes
        saveToPersistenceStore()
    }
    
    // MARK: - Actions
    func toggleIsComplete( goal: Goal ){
        goal.isComplete.toggle()
        saveToPersistenceStore()
    }
    
    // MARK: - Persistenace
    // create a place to STORE, SAVE, AND LOAD
    /*
     - Do
     - Catch
     - Decode through
     - class Song: Codable
     */
    
    
    // STORE
    /*
     creating a specific location on phone: Playlist.json
     */
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("Goal.json")
        return fileURL
    }
    
    // SAVE
    /*
     1. Encode data to JSON - must be written in JSOn
     - data needs to be formatted(encoded/codable)
     - go to Model > Songs and add this:
     - class Song: Codable
     ex: let data = try JSONEncoder().encode(songs)
     */
    func saveToPersistenceStore() {
        do {
            /* 1. in order to store data on phone need to ENCODE
             - we need to encode and convert to json data
             - go to the Model > Songs and add this:
             - class Song: Codable
             
             2. if json is loaded - create the item
             */
            let data = try JSONEncoder().encode(goals)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error encoding our songs: \(error) -- \(error.localizedDescription)")
        }
    }
    
    // LOAD
    /*
     1. decoding
     */
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            // decode array of [Song].self, decoding from line above
            goals = try JSONDecoder().decode([Goal].self, from: data)
        } catch {
            print("Error decoding our data into songs: \(error) -- \(error.localizedDescription)")
        }
    }
} // End of class



