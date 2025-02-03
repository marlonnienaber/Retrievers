import Testing
import Retrievers

@Test("StatePublisher emits initial value")
func testStatePublisherInitialValue() async throws {
    let repository = TestingRepository()
    
    let viewModel1 = TestingViewModel(repository: repository)
    let viewModel2 = TestingViewModel(repository: repository)
    #expect(viewModel1.number == 0)
    #expect(viewModel2.number == 1)
    
    repository.triggerUpdate()
    #expect(viewModel1.number == 2)
    #expect(viewModel2.number == 2)
    
    let viewModel3 = TestingViewModel(repository: repository)
    #expect(viewModel1.number == 2)
    #expect(viewModel2.number == 2)
    #expect(viewModel3.number == 3)
    
    repository.triggerUpdate()
    #expect(viewModel1.number == 4)
    #expect(viewModel2.number == 4)
    #expect(viewModel3.number == 4)
}
