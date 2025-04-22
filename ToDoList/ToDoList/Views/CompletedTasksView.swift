import SwiftUI

struct CompletedTasksView: View {
    @StateObject private var viewModel = ToDoListViewModel()
    @StateObject private var weatherVM = WeatherViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                WeatherHeaderView(weatherVM: weatherVM)
                    .padding(.horizontal)
                    .background(Color(.systemBackground))
                    .shadow(radius: 2)
                
                Group {
                    if viewModel.completedTasks.isEmpty {
                        EmptyStateView(message: "No completed tasks yet")
                    } else {
                        List {
                            ForEach(viewModel.completedTasks) { task in
                                ToDoTaskRowView(task: task, viewModel: viewModel)
                            }
                            .onDelete(perform: viewModel.deleteTask)
                        }
                        .listStyle(PlainListStyle())
                    }
                }
            }
            .navigationTitle("Completed Tasks")
            .onAppear {
                weatherVM.fetchWeather()
            }
        }
        .tabItem {
            Label("Completed", systemImage: "checkmark")
        }
    }
}
