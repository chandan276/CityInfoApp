//
//  DBHandler.swift
//  CityInfoApp
//
//  Created by Chandan Singh on 26/07/19.
//  Copyright © 2019 Organization. All rights reserved.
//

import UIKit
import CoreData

class DBHandler {
    
    static var sharedInstance = DBHandler()
    private init() { }
    
    var cityDetails: [NSManagedObject] = []
    
    func save(cityName city: String, stateName state: String, cityPopulation population: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "CityDetails", in: managedContext)!
        let cityTableData = NSManagedObject(entity: entity, insertInto: managedContext)
        
        cityTableData.setValue(city, forKeyPath: "cityName")
        cityTableData.setValue(state, forKeyPath: "state")
        cityTableData.setValue(Int64(population), forKeyPath: "cityPopulation")
        cityTableData.setValue(Date(), forKeyPath: "creationDate")
        
        do {
            try managedContext.save()
            cityDetails.append(cityTableData)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    func fetchCityDetailsFromDB(sortedBy sortType: SortOrder, completion: @escaping ([NSManagedObject]?) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<CityDetails>(entityName: "CityDetails")
        
        var sortString = "creationDate" //Default
        switch sortType {
        case .name:
            sortString = "cityName"
            break
            
        case .population:
            sortString = "cityPopulation"
            break
            
        default:
            break
        }
        
        let sort = NSSortDescriptor(key: sortString, ascending: true)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            cityDetails = try managedContext.fetch(fetchRequest)
            completion(cityDetails)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            completion(nil)
        }
    }
    
    func deleteDataWith(cityName name: String, completion: @escaping (Bool) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<CityDetails>(entityName: "CityDetails")
        fetchRequest.predicate = NSPredicate(format: "cityName = %@", name)
        
        do {
            let objects = try managedContext.fetch(fetchRequest)
            for object in objects {
                managedContext.delete(object)
            }
            try managedContext.save()
            completion(true)
        } catch let error as NSError {
            // error handling
            print("Could not delete. \(error), \(error.userInfo)")
            completion(false)
        }
    }
}
