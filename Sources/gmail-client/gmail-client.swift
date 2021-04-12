import Foundation
import Combine

class Gmail {
    
    private static var bearerToken: String = ""
    private static var defaultHeadersWithAuth = ["Authorization" : "Bearer \(Gmail.bearerToken)"]
    
    static func setAuth(bearerToken: String) {
        Gmail.bearerToken = bearerToken
    }
    
    class Users {
        
        static func getProfile(userID: String) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.user.getProfile(userID: userID).request, headers: defaultHeadersWithAuth, requestBody: nil))
        }
        
        static func stop(userID: String) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.user.stop(userID: userID).request, headers: defaultHeadersWithAuth, requestBody: nil))
        }
        
        static func watch(userID: String, requestBody: [String : Any]) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.user.watch(userID: userID).request, headers: defaultHeadersWithAuth, requestBody: requestBody))
        }
        
    }
    
    class UsersDrafts {
        
        static func create(userID: String, type: API.resourceContentType, draft: [String : Any]) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.usersDrafts.create(userId: userID, type: type).request, headers: defaultHeadersWithAuth, requestBody: draft))
        }
        
        static func delete(userID: String, id: String) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.usersDrafts.delete(userId: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: nil))
        }
        
        static func get(userID: String, id: String) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.usersDrafts.get(userId: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: nil))
        }
        
        static func list(userID: String) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.usersDrafts.list(userId: userID).request, headers: defaultHeadersWithAuth, requestBody: nil))
        }
        
        static func send(userID: String, headers: [String : String], draft: [String : Any], type: API.resourceContentType) -> AnyPublisher<Data, URLError> {
            var headersWithAuth = headers
            headersWithAuth["Authorization"] = "Bearer \(Gmail.bearerToken)"
            return (API.executeRequest(APIRequest: API.usersDrafts.send(userId: userID, type: type).request, headers: headersWithAuth, requestBody: draft))
        }
        
        static func update(userID: String, draft: [String : Any], id: String, type: API.resourceContentType) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.usersDrafts.update(userId: userID, id: id, type: type).request, headers: defaultHeadersWithAuth, requestBody: draft))
        }
        
    }
    
    class UsersHistory {
        
        static func list(userID: String, startHistoryId: String) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.usersHistory.list(userID: userID, startHistoryId: startHistoryId).request, headers: defaultHeadersWithAuth, requestBody: nil))
        }
        
    }
    
    class UsersLabels {
        
        static func create(userID: String, requestBody: Label) -> AnyPublisher<Label, Error> {
            return UsersLabels.decodeToLabel(publisher: (API.executeRequest(APIRequest: API.usersLabels.create(userId: userID).request, headers: defaultHeadersWithAuth, requestBody: requestBody.dictionary)))
        }
        
        static func delete(userID: String, id: String) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.usersLabels.delete(userId: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: nil))
        }
        
        static func get(userID: String, id: String) -> AnyPublisher<Label, Error> {
            return UsersLabels.decodeToLabel(publisher: (API.executeRequest(APIRequest: API.usersLabels.get(userId: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
        static func list(userID: String) -> AnyPublisher<LabelList, Error> {
            return UsersLabels.decodeToLabelList(publisher: (API.executeRequest(APIRequest: API.usersLabels.list(userId: userID).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
        static func patch(userID: String, id: String, requestBody: Label) -> AnyPublisher<Label, Error> {
            return UsersLabels.decodeToLabel(publisher: (API.executeRequest(APIRequest: API.usersLabels.patch(userId: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: requestBody.dictionary)))
        }
        
        static func update(userID: String, id: String, requestBody: Label) -> AnyPublisher<Label, Error> {
            return UsersLabels.decodeToLabel(publisher: (API.executeRequest(APIRequest: API.usersLabels.update(userId: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: requestBody.dictionary)))
        }
        
    }
    
    class UsersMessages {
        
        static func batchDelete(userID: String, ids: [String]) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.usersMessages.batchDelete(userID: userID).request, headers: defaultHeadersWithAuth, requestBody: ["ids":ids]))
        }
        
        static func batchModify(userID: String, requestBody: UserMessagesBatchModifyBody) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.usersMessages.batchModify(userID: userID).request, headers: defaultHeadersWithAuth, requestBody: requestBody.dictionary))
        }
        
        static func delete(userID: String, id: String) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.usersMessages.delete(userID: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: nil))
        }
        
        static func importMessage(userID: String, type: API.resourceContentType, message: Message) -> AnyPublisher<Message, Error> {
            return UsersMessages.decodeToMessage(publisher: (API.executeRequest(APIRequest: API.usersMessages.importMessages(userID: userID, importType: type).request, headers: defaultHeadersWithAuth, requestBody: message.dictionary)))
        }
        
        static func insert(userID: String, type: API.resourceContentType, message: Message) -> AnyPublisher<Message, Error> {
            return UsersMessages.decodeToMessage(publisher: (API.executeRequest(APIRequest: API.usersMessages.insert(userID: userID, importType: type).request, headers: defaultHeadersWithAuth, requestBody: message.dictionary)))
        }
        
        static func modify(userID: String, id: String, modifiedMessageBody: ModifiedMessageBody) -> AnyPublisher<Message, Error> {
            return UsersMessages.decodeToMessage(publisher: (API.executeRequest(APIRequest: API.usersMessages.modify(userID: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: modifiedMessageBody.dictionary)))
        }
        
        static func send(userID: String, type: API.resourceContentType, message: Message) -> AnyPublisher<Message, Error> {
            return UsersMessages.decodeToMessage(publisher: (API.executeRequest(APIRequest: API.usersMessages.send(userID: userID, importType: type).request, headers: defaultHeadersWithAuth, requestBody: message.dictionary)))
        }
        
        static func trash(userID: String, id: String) -> AnyPublisher<Message, Error> {
            return UsersMessages.decodeToMessage(publisher: (API.executeRequest(APIRequest: API.usersMessages.trash(userID: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
        static func untrash(userID: String, id: String) -> AnyPublisher<Message, Error> {
            return UsersMessages.decodeToMessage(publisher: (API.executeRequest(APIRequest: API.usersMessages.untrash(userID: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
        static func list(userID: String) -> AnyPublisher<MessagesList, Error> {
            return UsersMessages.decodeToMessageList(publisher: (API.executeRequest(APIRequest: API.usersMessages.list(userID: userID).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
        static func get(userID: String, id: String) -> AnyPublisher<Message, Error> {
            return UsersMessages.decodeToMessage(publisher: (API.executeRequest(APIRequest: API.usersMessages.get(userID: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
    }
    
    class UsersThreads {
        
        static func get(userID: String, id: String) -> AnyPublisher<Thread, Error> {
            return UsersThreads.decodeToThread(publisher: (API.executeRequest(APIRequest: API.usersThreads.get(userID: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
        static func list(userID: String) -> AnyPublisher<ThreadList, Error> {
            return UsersThreads.decodeToThreadList(publisher: (API.executeRequest(APIRequest: API.usersThreads.list(userID: userID).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
        static func trash(userID: String, id: String) -> AnyPublisher<Thread, Error> {
            return UsersThreads.decodeToThread(publisher: (API.executeRequest(APIRequest: API.usersThreads.trash(userID: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
        static func untrash(userID: String, id: String) -> AnyPublisher<Thread, Error> {
            return UsersThreads.decodeToThread(publisher: (API.executeRequest(APIRequest: API.usersThreads.untrash(userID: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
        static func delete(userID: String, id: String) -> AnyPublisher<Data, URLError> {
            return (API.executeRequest(APIRequest: API.usersThreads.delete(userID: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: nil))
        }
        
        static func modify(userID: String, id: String, requestBody: ThreadModifyBody) -> AnyPublisher<Thread, Error> {
            return UsersThreads.decodeToThread(publisher: (API.executeRequest(APIRequest: API.usersThreads.untrash(userID: userID, id: id).request, headers: defaultHeadersWithAuth, requestBody: requestBody.dictionary)))
        }
        
    }
    
    class UsersSettings {
        
        static func getAutoForwarding(userID: String, id: String) -> AnyPublisher<AutoForwarding, Error> {
            return UsersSettings.decodeToAutoForwarding(publisher: (API.executeRequest(APIRequest: API.usersSettings.getAutoForwarding(userID: userID).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
        static func getImap(userID: String) -> AnyPublisher<ImapSettings, Error> {
            return UsersSettings.decodeToImapSetttings(publisher: (API.executeRequest(APIRequest: API.usersSettings.getImap(userID: userID).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
        static func getLanguage(userID: String) -> AnyPublisher<LanguageSettings, Error> {
            return UsersSettings.decodeToLanguageSettings(publisher: (API.executeRequest(APIRequest: API.usersSettings.getLanguage(userID: userID).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
        static func getPop(userID: String) -> AnyPublisher<PopSettings, Error> {
            return UsersSettings.decodeToPopSettings(publisher: (API.executeRequest(APIRequest: API.usersSettings.getPop(userID: userID).request, headers: defaultHeadersWithAuth, requestBody: nil)))
        }
        
    }
}
