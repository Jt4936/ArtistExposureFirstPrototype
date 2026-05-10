import SwiftUI

struct CreatorStoryView: View {
    @Environment(\.dismiss) var dismiss
    let artist: Artist
    
    @State private var progress: CGFloat = 0.0
    
    var body: some View {
        ZStack(alignment: .top) {
            // Mock Video Background
            Color.black.edgesIgnoringSafeArea(.all)
            
            Image(artist.bannerImageName)
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.8)
            
            VStack {
                // Progress bar placeholder
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 3)
                            .cornerRadius(1.5)
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: geometry.size.width * progress, height: 3)
                            .cornerRadius(1.5)
                    }
                }
                .frame(height: 3)
                .padding(.horizontal)
                .padding(.top, 10)
                
                // Header Info
                HStack {
                    Image(artist.profileImageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(artist.name)
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Behind the latest album • 2h ago")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(8)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                Spacer()
                
                // Bottom Interactive Elements
                VStack(alignment: .leading, spacing: 12) {
                    Text("Recording the acoustic sessions. So much fun putting this together!")
                        .font(.body)
                        .foregroundColor(.white)
                    
                    HStack {
                        PrimaryButton(title: "View Album Board") {
                            // Action to navigate to the related board
                            dismiss()
                        }
                        
                        Button(action: {
                            // Like action
                        }) {
                            Image(systemName: "heart")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.white.opacity(0.2))
                                .clipShape(Circle())
                        }
                    }
                }
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
        .onAppear {
            // Simple mock progress animation
            withAnimation(.linear(duration: 5.0)) {
                progress = 1.0
            }
            
            // Auto dismiss after 5 seconds for prototype feel
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                if progress >= 1.0 {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    CreatorStoryView(artist: MockData.shared.spaceyJane)
}
