import Retrievers

class TestingRepository {
    
    private var retrievalCounter = 0
    @Retriever var entity: Entity?
    
    init() {
        _entity.toRetrieveDo { [weak self] in
            guard let self else { return .defaultValue }
            return retrieveEntity()
        }
    }
    
    func retrieveEntity() -> Entity? {
        let number = retrievalCounter
        retrievalCounter += 1
        return Entity(number: number)
    }
    
    func triggerUpdate() {
        _entity.triggerUpdate()
    }
}

struct Entity {
    let number: Int
}
