//
//  ItemModel.swift
//  TodoList
//
//  Created by Dev Internee 1 on 07/09/2026.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    
    let id: String
    let title: String
    let isCompleted: Bool
    let iconName: String
    
    init(
        id: String = UUID().uuidString,
        title: String,
        isCompleted: Bool,
        iconName: String = "checkmark.circle"
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.iconName = iconName
    }
    
    func updateCompletion() -> ItemModel {
        ItemModel(
            id: id,
            title: title,
            isCompleted: !isCompleted,
            iconName: iconName
        )
    }
}
