import SwiftUI

@main
struct ArtistExposureFirstPrototypeApp: App {
    @StateObject private var mockData = MockData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mockData)
                .tint(.purple)
        }
    }
}
