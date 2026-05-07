import Foundation

// MARK: - Mock Data Environment

class MockData: ObservableObject {
    @Published var spaceyJane: Artist = Artist(
        name: "Spacey Jane",
        bio: "Aussie indie rock band bringing the sunshine and heartbreak.",
        bannerImageName: "bannerPlaceholder",
        profileImageName: "profilePlaceholder",
        isFollowed: false,
        followerCount: 1250000
    )
    
    @Published var trendingArtists: [Artist] = [
        Artist(
            name: "The Strokes",
            bio: "New York City rock band.",
            bannerImageName: "bannerPlaceholder",
            profileImageName: "profilePlaceholder",
            isFollowed: false,
            followerCount: 2500000
        ),
        Artist(
            name: "Phoebe Bridgers",
            bio: "Los Angeles based singer-songwriter.",
            bannerImageName: "bannerPlaceholder",
            profileImageName: "profilePlaceholder",
            isFollowed: true,
            followerCount: 1800000
        )
    ]
    
    @Published var mediaBoards: [MediaBoard] = [
        MediaBoard(
            title: "Tour Aesthetics '23",
            description: "A collection of tour stage designs and behind the scenes concepts.",
            coverImageName: "board1",
            tags: ["Stage", "Tour", "Aesthetics"],
            creatorName: "FanClub_123"
        ),
        MediaBoard(
            title: "Sunlight & Guitars",
            description: "Vintage filters and acoustic session vibes.",
            coverImageName: "board2",
            tags: ["Acoustic", "Vintage", "Vibes"],
            creatorName: "IndieLover99"
        ),
        MediaBoard(
            title: "Music Video Concepts",
            description: "Moodboard for our latest single's music video.",
            coverImageName: "board3",
            tags: ["Official", "Video", "BTS"],
            creatorName: "Spacey Jane"
        )
    ]
    
    @Published var highlightedPosts: [HighlightPost] = [
        HighlightPost(
            title: "New Single BTS",
            artistName: "Spacey Jane",
            description: "Check out how we recorded our latest track in the studio.",
            imageName: "highlight1",
            isOfficial: true
        ),
        HighlightPost(
            title: "Fan Art Feature",
            artistName: "Spacey Jane",
            description: "Absolutely loving this piece by @artsy_fan!",
            imageName: "highlight2",
            isOfficial: true
        )
    ]
    
    // Shared instance for preview convenience
    static let shared = MockData()
}
