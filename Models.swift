import Foundation
import SwiftUI

// MARK: - Core Models

struct Artist: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let bio: String
    let bannerImageName: String
    let profileImageName: String
    var isFollowed: Bool = false
    let followerCount: Int
    
    // Additional relations could be stored as IDs
}

struct MediaBoard: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let coverImageName: String
    let tags: [String]
    let creatorName: String
    var isSaved: Bool = false
}

struct HighlightPost: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let artistName: String
    let description: String
    let imageName: String
    let isOfficial: Bool
    var isSaved: Bool = false
}

enum DiscoverCategory: String, CaseIterable {
    case all = "All"
    case tagged = "Tagged"
    case archived = "Archived"
    case boards = "Boards"
}
