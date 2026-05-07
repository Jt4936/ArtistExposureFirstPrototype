import SwiftUI

struct CreateMenuView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                CreateMenuOption(
                    iconName: "square.and.pencil",
                    title: "Create Post",
                    description: "Share thoughts or media directly to your feed",
                    destination: AnyView(CreatePostView(isPresented: $isPresented))
                )
                
                Divider()
                
                CreateMenuOption(
                    iconName: "rectangle.stack.badge.plus",
                    title: "Create Board",
                    description: "Curate a new collection of media",
                    destination: AnyView(CreateBoardView(isPresented: $isPresented))
                )
                
                Divider()
                
                CreateMenuOption(
                    iconName: "arrow.up.doc",
                    title: "Upload Pin",
                    description: "Add a single photo or video to a board",
                    destination: AnyView(UploadPinView(isPresented: $isPresented))
                )
                
                Divider()
                
                CreateMenuOption(
                    iconName: "star.fill",
                    title: "Highlight Post",
                    description: "Feature a post as official content",
                    destination: AnyView(HighlightPostView(isPresented: $isPresented))
                )
            }
            .navigationTitle("Create")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isPresented = false }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

// MARK: - Create Post View
struct CreatePostView: View {
    @Binding var isPresented: Bool
    
    @State private var postTitle: String = ""
    @State private var caption: String = ""
    @State private var selectedTag: String? = nil
    @State private var isPublished: Bool = false
    
    let tags = ["Update", "Behind-the-scenes", "Official"]
    
    var body: some View {
        ScrollView {
            if isPublished {
                VStack(spacing: 24) {
                    Spacer().frame(height: 80)
                    
                    Image(systemName: "checkmark.seal.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.purple)
                    
                    VStack(spacing: 8) {
                        Text("Post Published")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Your post has been shared with your followers.")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer().frame(height: 40)
                    
                    PrimaryButton(title: "Done") {
                        isPresented = false
                    }
                }
                .padding()
                .transition(.scale.combined(with: .opacity))
            } else {
                VStack(alignment: .leading, spacing: 24) {
                    // Title Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Title")
                            .font(.headline)
                        TextField("Post title", text: $postTitle)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                    
                    // Caption Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Caption")
                            .font(.headline)
                        TextField("Write a caption...", text: $caption, axis: .vertical)
                            .lineLimit(4...8)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                    
                    // Tags
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Category")
                            .font(.headline)
                        
                        HStack(spacing: 12) {
                            ForEach(tags, id: \.self) { tag in
                                CategoryChip(
                                    title: tag,
                                    isSelected: selectedTag == tag,
                                    action: { selectedTag = tag }
                                )
                            }
                        }
                    }
                    
                    Spacer().frame(height: 20)
                    
                    // Publish Button
                    PrimaryButton(title: "Publish Post") {
                        withAnimation(.spring()) {
                            isPublished = true
                        }
                    }
                    .disabled(postTitle.isEmpty || caption.isEmpty)
                    .opacity(postTitle.isEmpty || caption.isEmpty ? 0.5 : 1.0)
                }
                .padding()
            }
        }
        .navigationTitle("Create Post")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Upload Pin View
struct UploadPinView: View {
    @Binding var isPresented: Bool
    
    @State private var caption: String = ""
    @State private var selectedBoard: String = "Tour Aesthetics ’23"
    @State private var isUploaded: Bool = false
    
    let boards = ["Tour Aesthetics ’23", "Sunlight & Guitars", "Music Video Concepts"]
    
    var body: some View {
        ScrollView {
            if isUploaded {
                VStack(spacing: 24) {
                    Spacer().frame(height: 80)
                    
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.purple)
                    
                    VStack(spacing: 8) {
                        Text("Pin Uploaded")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Your pin has been added to \(selectedBoard).")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer().frame(height: 40)
                    
                    PrimaryButton(title: "Done") {
                        isPresented = false
                    }
                }
                .padding()
                .transition(.scale.combined(with: .opacity))
            } else {
                VStack(alignment: .leading, spacing: 24) {
                    // Media Placeholder
                    Button(action: {}) {
                        VStack(spacing: 12) {
                            Image(systemName: "photo.on.rectangle.angled")
                                .font(.system(size: 40))
                                .foregroundColor(.purple)
                            Text("Add Photo or Video")
                                .font(.headline)
                                .foregroundColor(.purple)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)
                        .background(Color.purple.opacity(0.1))
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.purple.opacity(0.3), style: StrokeStyle(lineWidth: 2, dash: [6]))
                        )
                    }
                    
                    // Board Selector
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Select Board")
                            .font(.headline)
                        
                        Picker("Select Board", selection: $selectedBoard) {
                            ForEach(boards, id: \.self) { board in
                                Text(board).tag(board)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.horizontal, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    
                    // Caption Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Caption")
                            .font(.headline)
                        TextField("Write a short caption...", text: $caption, axis: .vertical)
                            .lineLimit(3...5)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                    
                    Spacer().frame(height: 20)
                    
                    // Upload Button
                    PrimaryButton(title: "Upload Pin") {
                        withAnimation(.spring()) {
                            isUploaded = true
                        }
                    }
                    .disabled(caption.isEmpty)
                    .opacity(caption.isEmpty ? 0.5 : 1.0)
                }
                .padding()
            }
        }
        .navigationTitle("Upload Pin")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Highlight Post View
struct HighlightPostView: View {
    @Binding var isPresented: Bool
    
    @State private var reason: String = ""
    @State private var selectedContent: String = "Tour Announcement"
    @State private var isHighlighted: Bool = false
    
    let contentOptions = ["Tour Announcement", "Studio Session", "Behind the Album"]
    
    var body: some View {
        ScrollView {
            if isHighlighted {
                VStack(spacing: 24) {
                    Spacer().frame(height: 80)
                    
                    Image(systemName: "star.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.purple)
                    
                    VStack(spacing: 8) {
                        Text("Highlighted as Official Content")
                            .font(.title2)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        Text("'\(selectedContent)' is now featured on your profile.")
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer().frame(height: 40)
                    
                    PrimaryButton(title: "Done") {
                        isPresented = false
                    }
                }
                .padding()
                .transition(.scale.combined(with: .opacity))
            } else {
                VStack(alignment: .leading, spacing: 24) {
                    
                    // Content Selector
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Select Content to Highlight")
                            .font(.headline)
                        
                        Picker("Select Content", selection: $selectedContent) {
                            ForEach(contentOptions, id: \.self) { option in
                                Text(option).tag(option)
                            }
                        }
                        .pickerStyle(.menu)
                        .padding(.horizontal, 8)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                    }
                    
                    // Reason Field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Highlight Reason")
                            .font(.headline)
                        TextField("Why should this be highlighted?", text: $reason, axis: .vertical)
                            .lineLimit(3...5)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                    }
                    
                    Spacer().frame(height: 20)
                    
                    // Highlight Button
                    PrimaryButton(title: "Mark as Official Highlight") {
                        withAnimation(.spring()) {
                            isHighlighted = true
                        }
                    }
                    .disabled(reason.isEmpty)
                    .opacity(reason.isEmpty ? 0.5 : 1.0)
                }
                .padding()
            }
        }
        .navigationTitle("Highlight Post")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CreateMenuOption: View {
    let iconName: String
    let title: String
    let description: String
    let destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 16) {
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(.purple)
                    .frame(width: 32)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(.systemBackground))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    CreateMenuView(isPresented: .constant(true))
}
