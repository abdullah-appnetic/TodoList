//
//  ListView.swift
//  TodoList
//
//  Created by Dev Internee 1 on 07/09/2026.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State private var showAddView = false
    
    var body: some View {
        
        ZStack(alignment: .bottomTrailing) {
            
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                if listViewModel.items.isEmpty {
                    emptyStateView
                } else {
                    List {
                        ForEach(
                            listViewModel.items
                        ) { item in
                            
                            ListRowView(item: item)
                                .contentShape(
                                    Rectangle()
                                )
                                .listRowBackground(
                                    Color(.systemBackground)
                                )
                                .onTapGesture {
                                    
                                    listViewModel.updateItem(
                                        item: item
                                    )
                                }
                        }
                        .onDelete(
                            perform: listViewModel.deleteItems
                        )
                        .onMove(
                            perform: listViewModel.moveItem
                        )
                    }
                    .listStyle(.insetGrouped)
                    .scrollContentBackground(.hidden)
                }
            }
            
            Button {
                
                withAnimation(.spring()) {
                    showAddView = true
                }
                
            } label: {
                
                Image(systemName: "plus")
                    .font(.title2.bold())
                    .foregroundStyle(.white)
                    .frame(
                        width: 58,
                        height: 58
                    )
                    .background(
                        Color.accentColor
                    )
                    .clipShape(Circle())
                    .shadow(
                        radius: 8,
                        y: 4
                    )
            }
            .padding(.trailing, 22)
            .padding(.bottom, 25)
            .scaleEffect(
                showAddView ? 0.9 : 1
            )
            .animation(
                .spring(),
                value: showAddView
            )
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            ToolbarItem(
                placement: .principal
            ) {
                
                HStack(spacing: 8) {
                    
                    Image(
                        systemName: "checklist"
                    )
                    .foregroundStyle(Color.accentColor)
                    
                    Text("DONEDAY")
                        .font(
                            .headline.weight(
                                .bold
                            )
                        )
                }
            }
            
            ToolbarItem(
                placement: .navigationBarLeading
            ) {
                EditButton()
            }
        }
        .sheet(isPresented: $showAddView) {
 
                AddView()
                    .environmentObject(
                        listViewModel
                    )
        
        }
    }
    
    private var headerView: some View {
        
        VStack(spacing: 14) {
            
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                
                Text("My Tasks")
                    .font(.largeTitle.bold())
                
                Text(
                    "\(listViewModel.completedItems) of \(listViewModel.items.count) completed"
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            Divider()
        }
        .padding(.horizontal, 20)
        .padding(.top, 15)
        .padding(.bottom, 8)
    }
    
    private var emptyStateView: some View {
        
        VStack(spacing: 18) {
            
            Spacer()
            
            Image(systemName: "pencil.and.list.clipboard")
                .font(
                    .system(size: 65)
                )
                .foregroundStyle(
                    Color.accentColor
                )
            
            Text("No Tasks Yet")
                .font(.title2.bold())
            
            Text(
                "Tap the + button to add your first todo."
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
            
            Spacer()
        }
        .padding(40)
    }
}

#Preview {
    
    NavigationStack {
        
        ListView()
            .environmentObject(
                ListViewModel()
            )
    }
}
