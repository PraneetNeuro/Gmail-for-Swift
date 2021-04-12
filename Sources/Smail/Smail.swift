import Foundation
import Combine

public class Smail : ObservableObject {
    
    private var mailID: String
    
    private var refreshInterval: Int
    
    @Published var userMessages: MessagesList?
    @Published var userThreads: ThreadList?
    var cancellables: Set<AnyCancellable> = []
    
    
    public init(authToken: String, mailID: String, refreshInterval: Int?) {
        Gmail.setAuth(bearerToken: authToken)
        self.mailID = mailID
        self.refreshInterval = refreshInterval ?? -1
    }
    
    public func fetchUserThreads() {
        Gmail.UsersThreads.list(userID: self.mailID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { threads in
                self.userThreads = threads
            })
            .store(in: &cancellables)
    }
    
    public func fetchUserMessages() {
        Gmail.UsersMessages.list(userID: self.mailID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { messages in
                self.userMessages = messages
            })
            .store(in: &cancellables)
    }
    
    
}
