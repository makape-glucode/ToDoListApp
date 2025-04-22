import XCTest
@testable import ToDoList

final class ToDoListViewModelTests: XCTestCase {
    var viewModel: ToDoListViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ToDoListViewModel()
        UserDefaults.standard.removeObject(forKey: "tasks")
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testAddTask() {
        let initialCount = viewModel.tasks.count
        let newTask = ToDoTask(title: "Test Task")
        
        viewModel.addTask(newTask)
        
        XCTAssertEqual(viewModel.tasks.count, initialCount + 1)
        XCTAssertEqual(viewModel.tasks.last?.title, "Test Task")
    }
    
    func testUpdateTask() {
        let task = ToDoTask(title: "Original Title")
        viewModel.addTask(task)
        
        var updatedTask = task
        updatedTask.title = "Updated Title"
        viewModel.updateTask(updatedTask)
        
        XCTAssertEqual(viewModel.tasks.first?.title, "Updated Title")
    }
    
    func testDeleteTask() {
        let task1 = ToDoTask(title: "Task 1")
        let task2 = ToDoTask(title: "Task 2")
        viewModel.addTask(task1)
        viewModel.addTask(task2)
        
        let indexSet = IndexSet(integer: 0)
        viewModel.deleteTask(at: indexSet)
        
        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, "Task 2")
    }
    
    func testToggleTaskCompletion() {
        let task = ToDoTask(title: "Task", isCompleted: false)
        viewModel.addTask(task)
        
        viewModel.toggleTaskCompletion(task)
        XCTAssertTrue(viewModel.tasks.first?.isCompleted ?? false)
        
        viewModel.toggleTaskCompletion(viewModel.tasks.first!)
        XCTAssertFalse(viewModel.tasks.first?.isCompleted ?? true)
    }
    
    func testFilteredTasks() {
        let task1 = ToDoTask(title: "Task 1", isCompleted: false)
        let task2 = ToDoTask(title: "Task 2", isCompleted: true)
        viewModel.addTask(task1)
        viewModel.addTask(task2)
        
        viewModel.showingCompletedTasks = false
        XCTAssertEqual(viewModel.filteredTasks.count, 1)
        XCTAssertEqual(viewModel.filteredTasks.first?.title, "Task 1")
        
        viewModel.showingCompletedTasks = true
        XCTAssertEqual(viewModel.filteredTasks.count, 1)
        XCTAssertEqual(viewModel.filteredTasks.first?.title, "Task 2")
    }
    
    func testPersistence() {
        let task = ToDoTask(title: "Persistent Task")
        viewModel.addTask(task)
        
        // Create a new viewModel to simulate app restart
        let newViewModel = ToDoListViewModel()
        XCTAssertEqual(newViewModel.tasks.count, 1)
        XCTAssertEqual(newViewModel.tasks.first?.title, "Persistent Task")
    }
}
