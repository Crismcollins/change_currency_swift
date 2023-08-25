//
//  reactnative_ui_to_swiftUIApp.swift
//  reactnative_ui_to_swiftUI
//
//  Created by Cristobal Molina Collins on 07-08-23.
//

import SwiftUI

@main
struct reactnative_ui_to_swiftUIApp: App {
    
    @StateObject var language = LanguageViewModel()
    
    init() {
        NavigationBarCustomStyle()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: HomeViewModel())
                .environmentObject(language)
        }
    }
    
    private func NavigationBarCustomStyle() {
        let navigationBar = UINavigationBar.appearance()
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = UIColor.systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.shadowColor = .none //remove bottom border line of bar
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }
}
