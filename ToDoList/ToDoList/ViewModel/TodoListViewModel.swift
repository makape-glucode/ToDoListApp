import Foundation
import Combine

class ToDoListViewModel: ObservableObject {
    @Published var tasks: [ToDoTask] = []
    @Published var showingCompletedTasks = false
    
    private let storageKey = "todo_tasks"
    
    init() {
        loadTasks()
    }
    
    var hasTasks: Bool {
        !tasks.isEmpty
    }
    
    var filteredTasks: [ToDoTask] {
        tasks.filter { $0.isCompleted == showingCompletedTasks }
    }
    
    var activeTasks: [ToDoTask] {
        tasks.filter { !$0.isCompleted }
    }
    
    var completedTasks: [ToDoTask] {
        tasks.filter { $0.isCompleted }
    }
    
    func addTask(_ task: ToDoTask) {
        tasks.append(task)
        saveTasks()
    }
    
    func updateTask(_ task: ToDoTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index] = task
            saveTasks()
        }
    }
    
    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
        saveTasks()
    }
    
    func toggleTaskCompletion(_ task: ToDoTask) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
            saveTasks()
        }
    }
    
    private func saveTasks() {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: storageKey)
        }
    }
    
    private func loadTasks() {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let decoded = try? JSONDecoder().decode([ToDoTask].self, from: data) {
            tasks = decoded
        }
    }
}
