import Combine

class TestingViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    private let repository: TestingRepository
    @Published var number: Int = -1
    
    init(repository: TestingRepository) {
        self.repository = repository
        
        repository.$entity
            .sink { [weak self] newEntity in
                guard let self else { return }
                transformDataToViewModelData(newEntity)
            }
            .store(in: &cancellables)
    }
    
    func transformDataToViewModelData(_ entity: Entity?) {
        number = entity?.number ?? -1
    }
}
