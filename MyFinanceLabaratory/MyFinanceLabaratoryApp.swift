//
//  MyFinanceLabaratoryApp.swift
//  MyFinanceLabaratory
//
//  Created by Asadbek Yoldoshev on 15/10/24.
//

import SwiftUI

@main
struct MyFinanceLabaratoryApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, CoreDataProvider.shared.persistentContainer.viewContext)
        }
    }
}
