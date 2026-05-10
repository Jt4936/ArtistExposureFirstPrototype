import SwiftUI

struct HomeDiscoveryView: View {
    @EnvironmentObject var mockData: MockData
    @Binding var showCreateMenu: Bool
    
    @State private var searchText = ""
    @State private var selectedCategory: DiscoverCategory = .all
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var filteredArtists: [Artist] {
        let all = [mockData.spaceyJane] + mockData.trendingArtists
        if searchText.isEmpty { return all }
        return all.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    var filteredBoards: [MediaBoard] {
        switch selectedCategory {
        case .boards:
            return mockData.mediaBoards
        case .tagged:
            return mockData.mediaBoards.filter { !$0.tags.isEmpty }
        case .archived:
            return []
        case .all:
            if searchText.isEmpty { return mockData.mediaBoards }
            return mockData.mediaBoards.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.tags.contains(where: { $0.localizedCaseInsensitiveContains(searchText) })
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            ScrollView {
                VStack(spacing: 20) {
                    // Search Bar
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search artists, boards, tags...", text: $searchText)
                    }
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    
                    // Categories
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(DiscoverCategory.allCases, id: \.self) { category in
                                CategoryChip(
                                    title: category.rawValue,
                                    isSelected: selectedCategory == category
                                ) {
                                    withAnimation {
                                        selectedCategory = category
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // Featured Artists
                    VStack(alignment: .leading) {
                        Text("Featured Artists")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach($mockData.trendingArtists) { $artist in
                                    if filteredArtists.contains(where: { $0.id == artist.id }) {
                                        NavigationLink(destination: ArtistProfileView(artist: $artist)) {
                                            ArtistCardView(artist: artist)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                if filteredArtists.contains(where: { $0.id == mockData.spaceyJane.id }) {
                                    NavigationLink(destination: ArtistProfileView(artist: $mockData.spaceyJane)) {
                                        ArtistCardView(artist: mockData.spaceyJane)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    // Discover Boards Grid
                    VStack(alignment: .leading) {
                        Text("Discover Boards")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(filteredBoards) { board in
                                NavigationLink(destination: MediaBoardDetailView(board: board)) {
                                    BoardCardView(board: board)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                        
                        if filteredBoards.isEmpty {
                            VStack(spacing: 12) {
                                Image(systemName: "magnifyingglass")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray.opacity(0.5))
                                Text("No results found")
                                    .font(.headline)
                                    .foregroundColor(.secondary)
                                Text("Try searching for something else")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                        }
                    }
                    
                    Spacer().frame(height: 80) // Space for floating button
                }
                .padding(.top)
            }
            
            // Floating Create Button
            Button(action: {
                showCreateMenu = true
            }) {
                Image(systemName: "plus")
                    .font(.title.weight(.semibold))
                    .padding()
                    .background(Color.purple)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .shadow(radius: 4, x: 0, y: 4)
            }
            .padding()
        }
        .navigationTitle("Discover")
    }
}

#Preview {
    NavigationStack {
        HomeDiscoveryView(showCreateMenu: .constant(false))
            .environmentObject(MockData.shared)
    }
}
