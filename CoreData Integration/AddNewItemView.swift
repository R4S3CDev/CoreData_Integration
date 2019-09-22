//
//  AddNewItemView.swift
//  CoreData Integration
//
//  Created by R4S3C on 2019-09-21.
//  Copyright © 2019 R4S3C. All rights reserved.
//

import SwiftUI
import CoreData

struct AddNewItemView: View {
    //This property has been injected from ContentView using .environment
    @Environment(\.managedObjectContext) var managedObjectContext
    
    // I'm passing the items from the ContentView as a property this way I can display the items
    var items: FetchedResults<Item>
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                let item = Item(context: self.managedObjectContext)
                item.name = "From Modal View: Test_\(self.items.count + 1)"
                item.date = Date()
                
                do {
                    try self.managedObjectContext.save()
                }
                catch {
                    // Catch Core Data error here
                }
                
            }) {
                Text("👉🏻Tap to create a test Item")
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.green)
            }
            .padding()
            
            List(items, id: \.self) { item in
                Text("\(item.name ?? "UNKNOWN")")
            }
        }
    }
}
