//
//  ListViewModel.swift
//  TodoList
//
//  Created by Dev Internee 1 on 07/09/2026.
//

import Foundation
import Combine
import SwiftUI

/*
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 */

class ListViewModel: ObservableObject {
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    private let itemsKey = "todo_items"
    
    init() {
        getItems()
    }
    
    func getItems() {
        
        guard let savedData = UserDefaults.standard.data(forKey: itemsKey) else {
            
            items = [
                
            ]
            
            return
        }
        
        do {
            let decodedItems = try JSONDecoder().decode(
                [ItemModel].self,
                from: savedData
            )
            
            items = decodedItems
            
        } catch {
            print("Error decoding items: \(error)")
        }
    }
    
    func addItem(
        text: String,
        iconName: String
    ) {
        let newItem = ItemModel(
            title: text,
            isCompleted: false,
            iconName: iconName
        )
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            items.append(newItem)
        }
    }
    
    func updateItem(item: ItemModel) {
        
        if let index = items.firstIndex(where: {
            $0.id == item.id
        }) {
            
            withAnimation(.spring(response: 0.35, dampingFraction: 0.7)) {
                items[index] = item.updateCompletion()
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            items.remove(atOffsets: offsets)
        }
    }
    
    func moveItem(
        from source: IndexSet,
        to destination: Int
    ) {
        
        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
            items.move(
                fromOffsets: source,
                toOffset: destination
            )
        }
    }
    
    private func saveItems() {
        
        do {
            let encodedItems = try JSONEncoder().encode(items)
            
            UserDefaults.standard.set(
                encodedItems,
                forKey: itemsKey
            )
            
        } catch {
            print("Error encoding items: \(error)")
        }
    }
    
    var completedItems: Int {
        items.filter { $0.isCompleted }.count
    }
    
    var progress: Double {
        
        guard !items.isEmpty else {
            return 0
        }
        
        return Double(completedItems) / Double(items.count)
    }
}
