import SwiftUI

struct EmptyStateView: View {
    var message: String = "No tasks yet"
    var subtitle: String = "Tap the + button to add a new task"
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "note.text")
                .font(.system(size: 50))
                .foregroundColor(.gray)
                .padding()
            Text(message)
                .font(.title2)
                .foregroundColor(.gray)
            Text(subtitle)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
        }
    }
}
