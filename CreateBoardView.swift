import SwiftUI

struct CreateBoardView: View {
    @Binding var isPresented: Bool
    
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var selectedTags: Set<String> = []
    
    @State private var isPublished: Bool = false
    
    let sampleTags = ["Aesthetic", "Tour", "Acoustic", "Vintage", "Studio", "Vibes", "Official", "Fan Art"]
    
    var body: some View {
        ScrollView {
            if isPublished {
                VStack(spacing: 20) {
                    Spacer().frame(height: 60)
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                    
                    Text("Board Published!")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Your new board '\(title)' is now live.")
                        .foregroundColor(.secondary)
                    
                    Spacer().frame(height: 40)
                    
                    PrimaryButton(title: "Done") {
                        isPresented = false
                    }
                }
                .padding()
                .transition(.opacity)
            } else {
                VStack(alignment: .leading, spacing: 20) {
                    
                    // Cover Image Placeholder
                    PlaceholderImage(color: .purple, iconName: "camera.fill")
                        .frame(height: 180)
                        .cornerRadius(12)
                        .overlay(
                            Text("Add Cover Image")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.black.opacity(0.4))
                                .cornerRadius(8)
                        )
                    
                    // Form Fields
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Title")
                            .font(.headline)
                        TextField("e.g. Tour Aesthetics '23", text: $title)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Description")
                            .font(.headline)
                        TextField("What is this board about?", text: $description, axis: .vertical)
                            .lineLimit(3...6)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                    }
                    
                    // Tags
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Tags")
                            .font(.headline)
                        
                        // Simple wrap layout for tags
                        let chunkedTags = sampleTags.chunked(into: 4)
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(chunkedTags, id: \.self) { row in
                                HStack {
                                    ForEach(row, id: \.self) { tag in
                                        Button(action: {
                                            if selectedTags.contains(tag) {
                                                selectedTags.remove(tag)
                                            } else {
                                                selectedTags.insert(tag)
                                            }
                                        }) {
                                            Text("#\(tag)")
                                                .font(.subheadline)
                                                .padding(.horizontal, 12)
                                                .padding(.vertical, 6)
                                                .background(selectedTags.contains(tag) ? Color.purple : Color(.systemGray5))
                                                .foregroundColor(selectedTags.contains(tag) ? .white : .primary)
                                                .clipShape(Capsule())
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Spacer().frame(height: 40)
                    
                    // Publish Button
                    PrimaryButton(title: "Publish Board") {
                        withAnimation {
                            isPublished = true
                        }
                    }
                    .disabled(title.isEmpty)
                    .opacity(title.isEmpty ? 0.6 : 1.0)
                }
                .padding()
            }
        }
        .navigationTitle("New Board")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Helper extension to chunk arrays for the tag grid
extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

#Preview {
    NavigationStack {
        CreateBoardView(isPresented: .constant(true))
    }
}
