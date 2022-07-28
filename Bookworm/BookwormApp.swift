//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Woody Nichols on 6/20/22.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject private var dataController = DataController()  // @StateObject keeps variable alive for app lifetime
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
