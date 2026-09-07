//
//  AddView.swift
//  TodoList
//
//  Created by Dev Internee 1 on 07/09/2026.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var listViewModel: ListViewModel
    
    @State private var textFieldText: String = ""
    
    @State private var selectedIcon: String = "checkmark.circle"
    
    @State private var showIconPicker: Bool = false
    
    @State private var alertTitle: String = ""
    @State private var alertIsPresented: Bool = false
    
    private let icons = [
        "checkmark.circle",
        "star.fill",
        "heart.fill",
        "house.fill",
        "person.fill",
        "book.fill",
        "pencil",
        "briefcase.fill",
        "cart.fill",
        "bag.fill",
        "calendar",
        "clock.fill",
        "bell.fill",
        "flag.fill",
        "folder.fill",
        "paperplane.fill",
        "message.fill",
        "phone.fill",
        "envelope.fill",
        "camera.fill",
        "photo.fill",
        "music.note",
        "headphones",
        "gamecontroller.fill",
        "film.fill",
        "tv.fill",
        "desktopcomputer",
        "iphone",
        "wifi",
        "car.fill",
        "airplane",
        "bicycle",
        "figure.walk",
        "figure.run",
        "dumbbell.fill",
        "fork.knife",
        "cup.and.saucer.fill",
        "takeoutbag.and.cup.and.straw.fill",
        "drop.fill",
        "leaf.fill",
        "sun.max.fill",
        "moon.fill",
        "cloud.fill",
        "bolt.fill",
        "lightbulb.fill",
        "lock.fill",
        "key.fill",
        "gearshape.fill"
    ]
    
    var body: some View {
        
        ScrollView {
            
            VStack(spacing: 24) {
                                
                VStack(spacing: 12) {
                    
                    Image(systemName: selectedIcon)
                        .font(.system(size: 45))
                        .foregroundStyle(Color.accentColor)
                        .frame(
                            width: 90,
                            height: 90
                        )
                        .background(
                            Color.accentColor.opacity(0.12)
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 24
                            )
                        )
                        .symbolEffect(
                            .bounce,
                            value: selectedIcon
                        )
                    
                    Text("Choose an icon")
                        .font(.headline)
                    
                    Button {
                        withAnimation(.spring()) {
                            showIconPicker = true
                        }
                    } label: {
                        
                        HStack {
                            Image(systemName: "square.grid.2x2")
                            Text("Select Icon")
                        }
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(Color.accentColor)
                    }
                }
                .padding(.top, 15)
                                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Task")
                        .font(.headline)
                    
                    TextField(
                        "What do you need to do?",
                        text: $textFieldText
                    )
                    .padding(.horizontal)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 55
                    )
                    .background(
                        Color(.systemGray6)
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 14
                        )
                    )
                }
                                
                Button {
                    saveButtonPressed()
                } label: {
                    
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("Add Todo")
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(
                        maxWidth: .infinity,
                        minHeight: 55
                    )
                    .background(
                        Color.accentColor
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 14
                        )
                    )
                }
                .disabled(
                    textFieldText
                        .trimmingCharacters(
                            in: .whitespacesAndNewlines
                        )
                        .isEmpty
                )
                .opacity(
                    textFieldText
                        .trimmingCharacters(
                            in: .whitespacesAndNewlines
                        )
                        .isEmpty ? 0.5 : 1
                )
                .animation(
                    .easeInOut(duration: 0.2),
                    value: textFieldText.isEmpty
                )
            }
            .padding(20)
        }
        .navigationTitle("Add Todo")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showIconPicker) {
            IconPickerView(
                selectedIcon: $selectedIcon,
                icons: icons
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
        .alert(
            alertTitle,
            isPresented: $alertIsPresented
        ) {
            Button("OK") {
                alertIsPresented = false
            }
        }
    }
    
    private func saveButtonPressed() {
        
        if textIsAppropriate() {
            
            let cleanedText = textFieldText
                .trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
            
            listViewModel.addItem(
                text: cleanedText,
                iconName: selectedIcon
            )
            
            dismiss()
        }
    }
    
    private func textIsAppropriate() -> Bool {
        
        let cleanedText = textFieldText
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
        
        if cleanedText.count < 3 {
            
            alertTitle =
            "Your todo must be at least 3 characters long."
            
            alertIsPresented = true
            
            return false
        }
        
        return true
    }
}

struct IconPickerView: View {
    
    @Binding var selectedIcon: String
    
    let icons: [String]
    
    @Environment(\.dismiss) private var dismiss
    
    private let columns = [
        GridItem(.adaptive(minimum: 60))
    ]
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                LazyVGrid(
                    columns: columns,
                    spacing: 18
                ) {
                    
                    ForEach(icons, id: \.self) { icon in
                        
                        Button {
                            
                            withAnimation(
                                .spring(
                                    response: 0.3,
                                    dampingFraction: 0.6
                                )
                            ) {
                                selectedIcon = icon
                            }
                            
                            dismiss()
                            
                        } label: {
                            
                            Image(systemName: icon)
                                .font(.title2)
                                .foregroundStyle(
                                    selectedIcon == icon
                                    ? .white
                                    : .primary
                                )
                                .frame(
                                    width: 55,
                                    height: 55
                                )
                                .background(
                                    selectedIcon == icon
                                    ? Color.accentColor
                                    : Color(.systemGray6)
                                )
                                .clipShape(
                                    RoundedRectangle(
                                        cornerRadius: 14
                                    )
                                )
                                .scaleEffect(
                                    selectedIcon == icon
                                    ? 1.08
                                    : 1
                                )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Choose an Icon")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    
    NavigationStack {
        AddView()
            .environmentObject(
                ListViewModel()
            )
    }
}
