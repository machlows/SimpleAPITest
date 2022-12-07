import XCTest
import Combine

extension XCTestCase {
    func awaitCompletion<T: Publisher>(
        of publisher: T,
        timeout: TimeInterval = 10
    ) throws -> [T.Output] {
        let expectation = self.expectation(
            description: "Awaiting publisher completion"
        )

        var completion: Subscribers.Completion<T.Failure>?
        var output = [T.Output]()

        let cancellable = publisher.sink {
            completion = $0
            expectation.fulfill()
        } receiveValue: {
            output.append($0)
        }

        waitForExpectations(timeout: timeout)

        switch completion {
        case .failure(let error):
            throw error
        case .finished:
            return output
        case nil:
            cancellable.cancel()
            return []
        }
    }
}
