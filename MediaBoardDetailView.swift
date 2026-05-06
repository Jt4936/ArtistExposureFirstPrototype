import SwiftUI

struct MediaBoardDetailView: View {
    @State var board: MediaBoard
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Image
                PlaceholderImage(color: .purple, iconName: "photo.on.rectangle")
                    .frame(height: 250)
                    .cornerRadius(16)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    // Title and Actions
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(board.title)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text("Curated by \(board.creatorName)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            board.isSaved.toggle()
                        }) {
                            Image(systemName: board.isSaved ? "bookmark.fill" : "bookmark")
                                .font(.title2)
                                .foregroundColor(.purple)
                                .padding(12)
                                .background(Color.purple.opacity(0.1))
                                .clipShape(Circle())
                        }
                    }
                    
                    // Description
                    Text(board.description)
                        .font(.body)
                        .foregroundColor(.primary)
                    
                    // Tags
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(board.tags, id: \.self) { tag in
                                Text("#\(tag)")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 6)
                                    .background(Color.purple.opacity(0.1))
                                    .foregroundColor(.purple)
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    
                    Divider().padding(.vertical, 8)
                    
                    // Interaction Buttons
                    VStack(spacing: 12) {
                        PrimaryButton(title: board.isSaved ? "Saved to Library" : "Save Board") {
                            board.isSaved.toggle()
                        }
                        
                        PrimaryButton(title: "Follow \(board.creatorName)", isOutlined: true) {
                            // Follow action placeholder
                        }
                    }
                }
                .padding(.horizontal)
                
                // Grid of Pins Placeholder
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                    ForEach(0..<6, id: \.self) { _ in
                        PlaceholderImage(color: .gray, iconName: "photo")
                            .frame(height: 140)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .padding(.top)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        MediaBoardDetailView(board: MockData.shared.mediaBoards[0])
    }
}
