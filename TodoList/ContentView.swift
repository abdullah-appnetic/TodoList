//
//  ContentView.swift
//  TodoList
//
//  Created by Dev Internee 1 on 07/09/2026.
//

/*
 MVVM Architecture
 
 M - Model - Data point
 V - View - UI
 VM - ViewModel - Manages Models for Views
 */


import SwiftUI

struct ContentView: View {
    
    @State var listViewModel: ListViewModel = ListViewModel()
    
    var body: some View {
        NavigationView {
            ListView()
        }
        .environmentObject(listViewModel)
    }
}

#Preview {
    ContentView()
}
