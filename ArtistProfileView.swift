import SwiftUI

struct ArtistProfileView: View {
    @EnvironmentObject var mockData: MockData
    @Binding var artist: Artist
    
    @State private var showCreatorStory = false
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Banner Placeholder
                PlaceholderImage(color: .purple, iconName: "photo")
                    .frame(height: 200)
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [.clear, .black.opacity(0.6)]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                    )
                
                VStack(alignment: .leading, spacing: 16) {
                    // Header Info
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(artist.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text("\(artist.followerCount.formatted()) followers")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        
                        Button(action: {
                            artist.isFollowed.toggle()
                        }) {
                            Text(artist.isFollowed ? "Following" : "Follow")
                                .fontWeight(.semibold)
                                .padding(.horizontal, 20)
                                .padding(.vertical, 8)
                                .background(artist.isFollowed ? Color.gray.opacity(0.2) : Color.purple)
                                .foregroundColor(artist.isFollowed ? .primary : .white)
                                .clipShape(Capsule())
                        }
                    }
                    
                    // Bio
                    Text(artist.bio)
                        .font(.body)
                    
                    // Creator Story Button
                    Button(action: {
                        showCreatorStory = true
                    }) {
                        HStack {
                            Image(systemName: "play.circle.fill")
                                .font(.title2)
                                .foregroundColor(.purple)
                            VStack(alignment: .leading) {
                                Text("Creator Story")
                                    .fontWeight(.semibold)
                                Text("Behind the latest album")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Divider().padding(.vertical, 8)
                    
                    // Official Content Highlights
                    Text("Official Highlights")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(mockData.highlightedPosts) { post in
                                NavigationLink(destination: HighlightDetailView(post: post)) {
                                    VStack(alignment: .leading) {
                                        PlaceholderImage(color: .indigo, iconName: "star.fill")
                                            .frame(width: 140, height: 180)
                                            .cornerRadius(12)
                                        Text(post.title)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .lineLimit(1)
                                    }
                                    .frame(width: 140)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                    
                    Divider().padding(.vertical, 8)
                    
                    // Media Boards
                    Text("Artist Boards")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(mockData.mediaBoards) { board in
                            NavigationLink(destination: MediaBoardDetailView(board: board)) {
                                BoardCardView(board: board)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .padding()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
        .fullScreenCover(isPresented: $showCreatorStory) {
            CreatorStoryView(artist: artist)
        }
    }
}

#Preview {
    NavigationStack {
        ArtistProfileView(artist: .constant(MockData.shared.spaceyJane))
            .environmentObject(MockData.shared)
    }
}
