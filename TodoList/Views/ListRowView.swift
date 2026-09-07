//
//  ListRowView.swift
//  TodoList
//
//  Created by Dev Internee 1 on 07/09/2026.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    var body: some View {
        
        HStack(spacing: 14) {
            
            // MARK: - Todo Icon
            
            Image(systemName: item.iconName)
                .font(.title2)
                .foregroundStyle(
                    item.isCompleted
                    ? .gray
                    : .accentColor
                )
                .frame(
                    width: 45,
                    height: 45
                )
                .background(
                    item.isCompleted
                    ? Color.gray.opacity(0.12)
                    : Color.accentColor.opacity(0.12)
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 12
                    )
                )
                .scaleEffect(
                    item.isCompleted ? 0.9 : 1
                )
                .animation(
                    .spring(response: 0.35),
                    value: item.isCompleted
                )
            
            // MARK: - Title
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(item.title)
                    .font(.headline)
                    .foregroundStyle(
                        item.isCompleted
                        ? .secondary
                        : .primary
                    )
                    .strikethrough(
                        item.isCompleted,
                        color: .secondary
                    )
                
                Text(
                    item.isCompleted
                    ? "Completed"
                    : "To do"
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // MARK: - Completion Icon
            
            Image(
                systemName: item.isCompleted
                ? "checkmark.circle.fill"
                : "circle"
            )
            .font(.title2)
            .foregroundStyle(
                item.isCompleted
                ? .green
                : .secondary
            )
            .symbolEffect(
                .bounce,
                value: item.isCompleted
            )
        }
        .padding(.vertical, 10)
        .opacity(item.isCompleted ? 0.65 : 1)
    }
}

#Preview {
    
    let item1 = ItemModel(
        title: "Complete SwiftUI project",
        isCompleted: false,
        iconName: "swift"
    )
    
    let item2 = ItemModel(
        title: "Drink some water",
        isCompleted: true,
        iconName: "drop.fill"
    )
    
    VStack {
        ListRowView(item: item1)
        ListRowView(item: item2)
    }
    .padding()
}
