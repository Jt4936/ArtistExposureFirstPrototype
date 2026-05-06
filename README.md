# Artist Exposure First Prototype

## Overview
This is a semi-functional SwiftUI iOS prototype for the "Exposure First: Artist Media Discovery" application. The app connects fans with their favorite artists by curating mood boards and exploring official content.

## Value Branch
This specific value branch focuses on **Artist Visibility and Exposure**. The goal is to provide tools and spaces where fans can explore an artist’s profile, browse curated media boards, view highlighted official posts, and engage with behind-the-scenes content that amplifies an artist's creative process.

## Main Features
- **Home Discovery**: A central feed to search and discover categorized content (Tagged, Archived, Boards).
- **Artist Profile**: A rich profile showcasing Spacey Jane, their bio, follower counts, and curated boards.
- **Media Boards**: Detail views for curated collections, complete with save/follow interactions and tag filtering.
- **Creation Flow**: An accessible floating menu guiding users through creating posts, boards, and highlighting content.
- **Official Highlights**: Standout pages for official content verified by the artist.

## Meeting Prototype Requirements
This prototype demonstrates a **semi-functional state** by using:
- Pure SwiftUI architecture that compiles and runs in Xcode.
- `MockData` instead of an external API to guarantee consistent local data.
- State variables (`@State`, `@Binding`, `@EnvironmentObject`) to show interactive flows (e.g., following an artist, saving a board, and the "Board Published" confirmation state).
- Placeholder visual elements (`PlaceholderImage`) demonstrating where rich media will reside, avoiding real image/video uploads while conveying complete structural intent.
- A modern, clean, and accessible UI with a consistent purple/pastel aesthetic.

## Note on AI Use
AI was utilized for scaffolding the initial project structure, UI component boilerplate, and rapid iteration of SwiftUI code. However, all final design decisions, interactions, and aesthetic direction were carefully reviewed and refined by the student to meet the checkpoint assignment requirements.
