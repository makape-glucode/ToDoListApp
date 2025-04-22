import SwiftUI

struct AddTaskView: View {
    @ObservedObject var viewModel: ToDoListViewModel
    @State private var title: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $title)
                    .textFieldStyle(.roundedBorder)
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        if !title.isEmpty {
                            let newTask = ToDoTask(title: title)
                            viewModel.addTask(newTask)
                            dismiss()
                        }
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
