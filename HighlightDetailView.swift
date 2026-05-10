import SwiftUI

struct HighlightDetailView: View {
    @State var post: HighlightPost
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Main Content Image
                Image(post.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 350)
                    .clipped()
                    .cornerRadius(16)
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 16) {
                    if post.isOfficial {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundColor(.blue)
                            Text("Official Content")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(post.title)
                                .font(.title)
                                .fontWeight(.bold)
                            Text(post.artistName)
                                .font(.headline)
                                .foregroundColor(.purple)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            post.isSaved.toggle()
                        }) {
                            Image(systemName: post.isSaved ? "heart.fill" : "heart")
                                .font(.title2)
                                .foregroundColor(post.isSaved ? .red : .gray)
                                .padding(12)
                                .background(Color.gray.opacity(0.1))
                                .clipShape(Circle())
                        }
                    }
                    
                    Text(post.description)
                        .font(.body)
                        .padding(.top, 4)
                    
                    Divider().padding(.vertical, 8)
                    
                    // Interaction Buttons
                    VStack(spacing: 12) {
                        PrimaryButton(title: "View Artist Profile") {
                            // Action
                        }
                        
                        PrimaryButton(title: "Share", isOutlined: true) {
                            // Action
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        HighlightDetailView(post: MockData.shared.highlightedPosts[0])
    }
}
