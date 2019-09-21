//
//  ContentView.swift
//  CoreData Integration
//
//  Created by R4S3C on 2019-09-21.
//  Copyright © 2019 R4S3C. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Item.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)]) var items: FetchedResults<Item>
    
    @State private var isPresentingSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    let item = Item(context: self.managedObjectContext)
                    item.name = "Test_\(self.items.count + 1)"
                    item.date = Date()
                    
                    do {
                        try self.managedObjectContext.save()
                    }
                    catch {
                        // Catch Core Data error here
                    }
                    
                }) {
                    Text("Create a test Item")
                        .font(.system(.title, design: .rounded))
                }
                .padding()
                
                
                List(items, id: \.self) { item in
                    VStack(alignment: .leading) {
                        Text("\(item.name ?? "UNKNOWN")")
                        Text("\(item.date?.description ?? "UNKNOWN")")
                    }
                }
                
            }
            .sheet(isPresented: self.$isPresentingSheet) {
                AddNewItemView()
            }
            .navigationBarTitle(Text("Core Data Integration"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.isPresentingSheet.toggle()
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .font(.title)
            }))
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
