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
                    destination: AnyView(Text("Create Post View Placeholder").navigationTitle("Create Post"))
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
                    destination: AnyView(Text("Upload Pin View Placeholder").navigationTitle("Upload Pin"))
                )
                
                Divider()
                
                CreateMenuOption(
                    iconName: "star.fill",
                    title: "Highlight Post",
                    description: "Feature a post as official content",
                    destination: AnyView(Text("Highlight Post View Placeholder").navigationTitle("Highlight Post"))
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
