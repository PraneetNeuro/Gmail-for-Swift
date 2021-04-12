import Foundation
import Combine

public class Smail : ObservableObject {
    
    private var mailID: String
    
    private var refreshInterval: Int
    
    @Published public var userMessages: MessagesList?
    @Published public var userThreads: ThreadList?
    @Published public var userLabels: LabelList?
    @Published public var userDrafts: DraftList?
    
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
                print(threads)
            })
            .store(in: &cancellables)
    }
    
    public func fetchUserLabels() {
        Gmail.UsersLabels.list(userID: self.mailID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { labels in
                self.userLabels = labels
                print(labels)
            })
            .store(in: &cancellables)
    }
    
    public func fetchUserDrafts() {
        Gmail.UsersDrafts.list(userID: self.mailID)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { drafts in
                self.userDrafts = drafts
                print(drafts)
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
                print(messages)
            })
            .store(in: &cancellables)
    }
    
    
}
