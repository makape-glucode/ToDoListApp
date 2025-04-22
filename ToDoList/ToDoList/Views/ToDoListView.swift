import SwiftUI

struct ToDoListView: View {
    @StateObject private var viewModel = ToDoListViewModel()
    @StateObject private var weatherVM = WeatherViewModel()
    @State private var showingAddTask = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                WeatherHeaderView(weatherVM: weatherVM)
                    .padding(.horizontal)
                    .background(Color(.systemBackground))
                    .shadow(radius: 2)
                
                Group {
                    if viewModel.hasTasks {
                        Picker("Task Status", selection: $viewModel.showingCompletedTasks) {
                            Text("To Do").tag(false)
                            Text("Completed").tag(true)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        .padding(.top, 8)
                    }
                    
                    if viewModel.hasTasks {
                        List {
                            ForEach(viewModel.filteredTasks) { task in
                                ToDoTaskRowView(task: task, viewModel: viewModel)
                            }
                            .onDelete(perform: viewModel.deleteTask)
                        }
                        .listStyle(PlainListStyle())
                    } else {
                        EmptyStateView()
                    }
                }
            }
            .navigationTitle("Tasks")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddTask = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
            .onAppear {
                weatherVM.fetchWeather()
            }
        }
        .tabItem {
            Label("Tasks", systemImage: "list.bullet")
        }
    }
}

