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
    //Passing the managedObjectContext should be enough since already inject it in the environment. But no, it doesn't work here
    //@Environment(\.managedObjectContext) var managedObjectContext
    
    // Passing the context as a parameter from the ContentView works like a charm. In this case I do need to import CoreData
    var managedObjectContext: NSManagedObjectContext
    
    // If I try to create a fetchrequest here, the app crashed and I got this error: [SwiftUI] Context in environment is not connected to a persistent store coordinator: <NSManagedObjectContext: 0x600000e1e060>
    //@FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)]) var itemsFromFetch: FetchedResults<Item>
    
    // I'm passing the items from the ContentView as a property this way I can display the items
    var items: FetchedResults<Item>
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                let item = Item(context: self.managedObjectContext)
                item.name = "From Modal View: Test_\(self.items.count + 1)"
                item.date = Date()
                
                // This should save the new item created and eventually display it in the list. Right?
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
