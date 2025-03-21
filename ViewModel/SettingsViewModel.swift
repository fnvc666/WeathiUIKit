//
//  SettingsViewModel.swift
//  Weathi
//
//  Created by on 09/03/2025.
//
import Foundation
import CoreData

class SettingsViewModel {
    
    private let importFlagKey = "didImportCities"
    
    func importCitiesIfNeeded() {
        let defaults = UserDefaults.standard
        
        if defaults.bool(forKey: importFlagKey) {
            print("The cities have already been imported. Skip")
            return
        }
        
        print("Import cities...")
        guard let url = Bundle.main.url(forResource: "city.list", withExtension: "json") else {
            print("city.list.json file not found")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            guard let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else {
                return
            }
            
            importCitiesInBackground(jsonArray: jsonArray) {
                defaults.set(true, forKey: self.importFlagKey)
                print("Import cities completed")
            }
        } catch {
            print("Error during reading JSON: \(error)")
        }
    }
    
    func searchCities(by name: String) -> [CityEntity] {
        let context = CoreDataManager.shared.context
        let fetchRequest = NSFetchRequest<CityEntity>(entityName: "CityEntity")
        
        fetchRequest.predicate = NSPredicate(format: "name BEGINSWITH[cd] %@", name)
        fetchRequest.fetchLimit = 50
        
        do {
            let fetchedCities = try context.fetch(fetchRequest)
            
            var uniqueByName: [String: CityEntity] = [:]
            for city in fetchedCities {
                if let cityName = city.name, uniqueByName[cityName] == nil {
                    uniqueByName[cityName] = city
                }
            }
            return Array(uniqueByName.values)
            
        } catch {
            print("Error during searching cities: \(error)")
            return []
        }
    }
    
    private func importCitiesInBackground(jsonArray: [[String: Any]], completion: @escaping () -> Void) {
        let backgroundContext = CoreDataManager.shared.persistentContainer.newBackgroundContext()
        
        DispatchQueue.global(qos: .background).async {
            let batchSize = 5000
            for (index, cityDict) in jsonArray.enumerated() {
                let cityEntity = CityEntity(context: backgroundContext)
                cityEntity.id = (cityDict["id"] as? Int64) ?? 0
                cityEntity.name = (cityDict["name"] as? String) ?? ""
                cityEntity.state = (cityDict["state"] as? String) ?? ""
                cityEntity.country = (cityDict["country"] as? String) ?? ""
                
                if let coord = cityDict["coord"] as? [String: Any] {
                    cityEntity.lon = (coord["lon"] as? Double) ?? 0
                    cityEntity.lat = (coord["lat"] as? Double) ?? 0
                }
                
                if (index + 1) % batchSize == 0 {
                    do {
                        try backgroundContext.save()
                        backgroundContext.reset()
                    } catch {
                        print("Error during batch saving: \(error)")
                    }
                }
            }
            
            do {
                try backgroundContext.save()
            } catch {
                print("Error during final saving: \(error)")
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
