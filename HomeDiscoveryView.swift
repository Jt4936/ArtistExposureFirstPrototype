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
                                // Spacey Jane (Main Mock)
                                NavigationLink(destination: ArtistProfileView(artist: $mockData.spaceyJane)) {
                                    ArtistCardView(artist: mockData.spaceyJane)
                                }
                                .buttonStyle(PlainButtonStyle())
                                
                                // Trending Artists
                                ForEach($mockData.trendingArtists) { $artist in
                                    NavigationLink(destination: ArtistProfileView(artist: $artist)) {
                                        ArtistCardView(artist: artist)
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
                            ForEach(mockData.mediaBoards) { board in
                                NavigationLink(destination: MediaBoardDetailView(board: board)) {
                                    BoardCardView(board: board)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
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
