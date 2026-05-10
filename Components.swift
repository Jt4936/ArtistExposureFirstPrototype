import SwiftUI

// MARK: - Reusable UI Components

struct CategoryChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(isSelected ? .semibold : .regular)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.purple.opacity(0.2) : Color.gray.opacity(0.1))
                .foregroundColor(isSelected ? .purple : .primary)
                .clipShape(Capsule())
                .overlay(
                    Capsule()
                        .stroke(isSelected ? Color.purple : Color.clear, lineWidth: 1)
                )
        }
    }
}

struct PrimaryButton: View {
    let title: String
    var isOutlined: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(isOutlined ? Color.clear : Color.purple)
                .foregroundColor(isOutlined ? .purple : .white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(isOutlined ? Color.purple : Color.clear, lineWidth: 2)
                )
        }
    }
}

struct PlaceholderImage: View {
    let color: Color
    let iconName: String
    
    var body: some View {
        Rectangle()
            .fill(color.opacity(0.2))
            .overlay(
                Image(systemName: iconName)
                    .font(.largeTitle)
                    .foregroundColor(color)
            )
    }
}

// Media board card used in Discovery and Profile views
struct BoardCardView: View {
    let board: MediaBoard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(board.coverImageName)
                .resizable()
                .scaledToFill()
                .frame(height: 160)
                .clipped()
                .cornerRadius(12)
            
            Text(board.title)
                .font(.headline)
                .lineLimit(1)
            
            Text("by \(board.creatorName)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(12)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}

// Artist card used in Discovery view
struct ArtistCardView: View {
    let artist: Artist
    
    var body: some View {
        VStack {
            Image(artist.profileImageName)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            
            Text(artist.name)
                .font(.headline)
                .lineLimit(1)
            
            Text("\(artist.followerCount / 1000)k followers")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(width: 120)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(16)
    }
}
