import SwiftUI

struct ToDoTaskRowView: View {
    let task: ToDoTask
    @ObservedObject var viewModel: ToDoListViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                viewModel.toggleTaskCompletion(task)
            }) {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }
            .buttonStyle(.plain)
            
            Text(task.title)
                .font(.headline)
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
