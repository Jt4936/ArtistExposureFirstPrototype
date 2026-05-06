import SwiftUI

struct ContentView: View {
    @State private var showCreateMenu = false
    
    var body: some View {
        NavigationStack {
            HomeDiscoveryView(showCreateMenu: $showCreateMenu)
        }
        .sheet(isPresented: $showCreateMenu) {
            CreateMenuView(isPresented: $showCreateMenu)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(MockData.shared)
}
