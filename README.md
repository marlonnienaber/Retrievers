# Retrievers

## Description
A Retriever is a **powerful property wrapper** designed for use in repositories or services (usually used to encapsulate fetching logic used in multiple ViewModels) within larger Swift projects following the MVVM architecture. With a Retriever, **fetching data is as simple as accessing the wrapped property**. Additionally, Retrievers act as **Combine publishers**, allowing easy subscription and reactive updates.

## Example Usage

```
import SwiftUI
import Observation
import Retrievers

struct ExampleView: View {
    @State var viewModel = ExampleViewModel(repository: ExampleRepository())
    
    var body: some View {
        ForEach(viewModel.names, id: \.self) { name in
            Text(name)
        }
        Button("Refresh") {
            viewModel.refresh()
        }
        Button("Print Ages") {
            viewModel.printAges()
        }
    }
}

@Observable
class ExampleViewModel {
    @ObservationIgnored private var cancellables = Set<AnyCancellable>()
    @ObservationIgnored private let repository: ExampleRepository
    var names: [String] = []
    
    init(repository: ExampleRepository) {
        self.repository = repository
        
        repository.$people
            .sink { newPeople in
                self.names = newPeople.map { $0.name }
            }
            .store(in: &cancellables)
    }
    
    func refresh() {
        repository.refresh()
    }
    
    func printAges() {
        let people = repository.people
        people.forEach { 
            print($0.age) 
        }
    }
}

class ExampleRepository {
    @Retriever var people: [Person]
    
    init() {
        _people.toRetrieveDo {
            // Fetch data from disk/server
        }
    }
    
    func refresh() {
        _people.triggerUpdate()
    }
}
```

## Important Characteristics

Retrievers are **transient**, meaning they hold no state. Each time they are accessed, subscribed to, or updated, the closure passed to toRetrieveDo() is executed to fetch the current state. This makes them memory-efficient. 

On subscription, **observers are immediately synced** with the current state.

Retrievers require that the retrieval logic is explicitly defined using toRetrieveDo(). If this is not done, Retrievers fall back to a default value. To ensure this, **Retrievers can only wrap types that conform to the Defaultable protocol**, which enforces the presence of a defaultValue property. **Array and Optionals are Defaultable conforming types**.
