import Combine

@available(iOS 13.0, *)
@propertyWrapper
public class Retriever<SubjectType: Defaultable> {
    private var retriever: (() -> SubjectType)?
    private let subject = PassthroughSubject<SubjectType, Never>()

    public var projectedValue: AnyPublisher<SubjectType, Never> {
        Deferred { [weak self] in
            Future { promise in
                if let retriever = self?.retriever {
                    promise(.success(retriever()))
                } else {
                    promise(.success(SubjectType.defaultValue))
                }
            }
        }
        .merge(with: subject)
        .eraseToAnyPublisher()
    }

    public init() {}

    public func toRetrieveDo(_ retriever: @escaping () -> SubjectType) {
        self.retriever = retriever
    }

    public var wrappedValue: SubjectType {
        get {
            retriever?() ?? SubjectType.defaultValue
        }
    }

    public func triggerUpdate() {
        let newState = retriever?() ?? SubjectType.defaultValue
        subject.send(newState)
    }
}
