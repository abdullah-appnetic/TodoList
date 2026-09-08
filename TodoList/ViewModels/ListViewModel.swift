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
    
    @Published var items: [ItemModel] = []
    @AppStorage("todo_items") private var savedItemsData: Data = Data()
    
    init() {
        getItems()
    }
    
    func getItems() {
        
        // If there is no saved data
        guard !savedItemsData.isEmpty else {
            items = []
            return
        }
        
        do {
            let decodedItems = try JSONDecoder().decode(
                [ItemModel].self,
                from: savedItemsData
            )
            
            items = decodedItems
            
        } catch {
            print("Error decoding items: \(error)")
            items = []
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
        
        withAnimation(.spring()) {
            items.append(newItem)
        }
        
        saveItems()
    }
    
    func updateItem(item: ItemModel) {
        
        if let index = items.firstIndex(where: {
            $0.id == item.id
        }) {
            
            withAnimation(.spring()) {
                items[index] = item.updateCompletion()
            }
            
            saveItems()
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        
        withAnimation(.spring()) {
            items.remove(atOffsets: offsets)
        }
        
        saveItems()
    }
    
    func moveItem(
        from source: IndexSet,
        to destination: Int
    ) {
        
        withAnimation(.spring()) {
            items.move(
                fromOffsets: source,
                toOffset: destination
            )
        }
        
        saveItems()
    }
    
    private func saveItems() {
        
        do {
            
            let encodedItems = try JSONEncoder().encode(items)
            
            savedItemsData = encodedItems
            
        } catch {
            
            print("Error encoding items: \(error)")
        }
    }
    
    var completedItems: Int {
        items.filter {
            $0.isCompleted
        }.count
    }
}
