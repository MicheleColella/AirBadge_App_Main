
import SwiftUI
import Foundation

class SharedData: ObservableObject {
    @Published var doubleValue: Double = 0.0
}

@main
struct AirBadge_CopyApp: App {
    
    @StateObject var sharedData = SharedData()
    var body: some Scene {
        WindowGroup {
            TabView {
                MainView().preferredColorScheme(.light)
                    .tabItem {
                        Label("Today", systemImage: "clock")
                    }
                
                GraphCaleTest().preferredColorScheme(.light)
                    .tabItem {
                        Label("Calendar", systemImage: "calendar")
                    }
                UserModelView().preferredColorScheme(.light)
                    .tabItem {
                        Label("Badge", systemImage: "person.badge.clock")
                    }
            }.environmentObject(sharedData)
        }
    }
}


