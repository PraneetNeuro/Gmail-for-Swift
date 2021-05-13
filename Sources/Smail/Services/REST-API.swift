//
//  REST-API.swift
//  gmail-client
//
//  Created by Praneet S on 08/04/21.
//

import Foundation
import Combine

public enum HTTPMethod: String {
    case GET
    case PUT
    case POST
    case PATCH
    case DELETE
}

public class API {
    
    public struct Request {
        let requestURL: String
        let requestMethod: HTTPMethod
    }
    
    public static var baseURL = "https://gmail.googleapis.com"
    
    public static func executeRequest<T>(APIRequest: Request, headers: [String : String]?, requestBody: [String : Any]?, decodingType: T.Type) -> AnyPublisher<T, Error> where T: Decodable {
        
        let apiRequestURL = URL(string: API.baseURL + APIRequest.requestURL)
        if apiRequestURL == nil {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: apiRequestURL!)
        request.httpMethod = APIRequest.requestMethod.rawValue
        if let requestBody = requestBody {
            let jsonData = try? JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
        }
        request.allHTTPHeaderFields = headers
        
        let publisher = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return publisher
    }
    
    public enum resourceContentType {
        case Media
        case Metadata
    }
    
    public enum user {
        case getProfile(userID: String)
        case stop(userID: String)
        case watch(userID: String)
        
        var request: Request {
            switch self {
            case .getProfile(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/profile", requestMethod: .GET)
            case .stop(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/stop", requestMethod: .POST)
            case .watch(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/watch", requestMethod: .POST)
            }
        }
    }
    
    public enum usersDrafts {
        case create(userId: String, type: resourceContentType)
        case delete(userId: String, id: String)
        case get(userId: String, id: String)
        case list(userId: String)
        case send(userId: String, type: resourceContentType)
        case update(userId: String, id: String, type: resourceContentType)
        
        var request: Request {
            switch self {
            case .create(userId: let userId, type: let type):
                switch type {
                case .Media:
                    return Request(requestURL: "/upload/gmail/v1/users/\(userId)/drafts", requestMethod: .POST)
                case .Metadata:
                    return Request(requestURL: "/gmail/v1/users/\(userId)/drafts", requestMethod: .POST)
                }
            case .delete(userId: let userId, id: let id):
                return Request(requestURL: "/gmail/v1/users/\(userId)/drafts/\(id)", requestMethod: .DELETE)
            case .get(userId: let userId, id: let id):
                return Request(requestURL: "/gmail/v1/users/\(userId)/drafts/\(id)", requestMethod: .GET)
            case .list(userId: let userId):
                return Request(requestURL: "/gmail/v1/users/\(userId)/drafts", requestMethod: .GET)
            case .send(userId: let userId, type: let type):
                switch type {
                case .Media:
                    return Request(requestURL: "/upload/gmail/v1/users/\(userId)/drafts/send", requestMethod: .POST)
                case .Metadata:
                    return Request(requestURL: "/gmail/v1/users/\(userId)/drafts/send", requestMethod: .POST)
                }
            case .update(userId: let userId, id: let id, type: let type):
                switch type {
                case .Media:
                    return Request(requestURL: "/upload/gmail/v1/users/\(userId)/drafts/\(id)", requestMethod: .PUT)
                case .Metadata:
                    return Request(requestURL: "/gmail/v1/users/\(userId)/drafts/\(id)", requestMethod: .PUT)
                }
            }
        }
    }
    
    public enum usersHistory {
        case list(userID: String, startHistoryId: String)
        
        var request: Request {
            switch self {
            case .list(userID: let userID, startHistoryId: let startHistoryId):
                return Request(requestURL: "/gmail/v1/users/\(userID)/history?startHistoryId=\(startHistoryId)", requestMethod: .GET)
            }
        }
    }
    
    public enum usersLabels {
        case create(userId: String)
        case delete(userId: String, id: String)
        case get(userId: String, id: String)
        case list(userId: String)
        case patch(userId: String, id: String)
        case update(userId: String, id: String)
        
        var request: Request {
            switch self {
            case .create(userId: let userId):
                return Request(requestURL:"/gmail/v1/users/\(userId)/labels", requestMethod: .POST)
            case .delete(userId: let userId, id: let id):
                return Request(requestURL:"/gmail/v1/users/\(userId)/labels/\(id)", requestMethod: .DELETE)
            case .get(userId: let userId, id: let id):
                return Request(requestURL:"/gmail/v1/users/\(userId)/labels/\(id)", requestMethod: .GET)
            case .list(userId: let userId):
                return Request(requestURL:"/gmail/v1/users/\(userId)/labels", requestMethod: .GET)
            case .patch(userId: let userId, id: let id):
                return Request(requestURL:"/gmail/v1/users/\(userId)/labels/\(id)", requestMethod: .PATCH)
            case .update(userId: let userId, id: let id):
                return Request(requestURL:"/gmail/v1/users/\(userId)/labels/\(id)", requestMethod: .PUT)
            }
        }
    }
    
    public enum usersMessages {
        case batchDelete(userID: String)
        case batchModify(userID: String)
        case delete(userID: String, id: String)
        case get(userID: String, id: String)
        case importMessages(userID: String, importType: resourceContentType)
        case insert(userID: String, importType: resourceContentType)
        case list(userID: String)
        case modify(userID: String, id: String)
        case send(userID: String, importType: resourceContentType)
        case trash(userID: String, id: String)
        case untrash(userID: String, id: String)
        
        var request: Request {
            switch self {
            case .batchDelete(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/messages/batchDelete", requestMethod: .POST)
            case .batchModify(userID: let userID):
                return Request(requestURL:"/gmail/v1/users/\(userID)/messages/batchModify", requestMethod: .POST)
            case .delete(userID: let userID, id: let id):
                return Request(requestURL:"/gmail/v1/users/\(userID)/messages/\(id)", requestMethod: .DELETE)
            case .get(userID: let userID, id: let id):
                return Request(requestURL:"/gmail/v1/users/\(userID)/messages/\(id)", requestMethod: .GET)
            case .importMessages(userID: let userID, importType: let importType):
                switch importType {
                case .Media:
                    return Request(requestURL:"/upload/gmail/v1/users/\(userID)/messages/import", requestMethod: .POST)
                case .Metadata:
                    return Request(requestURL:"/gmail/v1/users/\(userID)/messages/import", requestMethod: .POST)
                }
            case .insert(userID: let userID, importType: let importType):
                switch importType {
                case .Media:
                    return Request(requestURL:"/upload/gmail/v1/users/\(userID)/messages", requestMethod: .POST)
                case .Metadata:
                    return Request(requestURL:"/gmail/v1/users/\(userID)/messages", requestMethod: .POST)
                }
            case .list(userID: let userID):
                return Request(requestURL:"/gmail/v1/users/\(userID)/messages", requestMethod: .GET)
            case .modify(userID: let userID, id: let id):
                return Request(requestURL:"/gmail/v1/users/\(userID)/messages/\(id)/modify", requestMethod: .POST)
            case .send(userID: let userID, importType: let importType):
                switch importType {
                case .Media:
                    return Request(requestURL:"/upload/gmail/v1/users/\(userID)/messages/send", requestMethod: .POST)
                case .Metadata:
                    return Request(requestURL:"/gmail/v1/users/\(userID)/messages/send", requestMethod: .POST)
                }
            case .trash(userID: let userID, id: let id):
                return Request(requestURL:"/gmail/v1/users/\(userID)/messages/\(id)/trash", requestMethod: .POST)
            case .untrash(userID: let userID, id: let id):
                return Request(requestURL:"/gmail/v1/users/\(userID)/messages/\(id)/untrash", requestMethod: .POST)
            }
        }
    }
    
    public enum messageAttachments {
        case get(userID: String, messageID: String, id: String)
        
        var request: String {
            switch self {
            case .get(userID: let userID, messageID: let messageID, id: let id):
                return "/gmail/v1/users/\(userID)/messages/\(messageID)/attachments/\(id)"
            }
        }
    }
    
    public enum usersSettings {
        case getAutoForwarding(userID: String)
        case getImap(userID: String)
        case getLanguage(userID: String)
        case getPop(userID: String)
        case getVacation(userID: String)
        case updateAutoForwarding(userID: String)
        case updateImap(userID: String)
        case updateLanguage(userID: String)
        case updatePop(userID: String)
        case updateVacation(userID: String)
        
        var request: Request {
            switch self {
            case .getAutoForwarding(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/autoForwarding", requestMethod: .GET)
            case .getImap(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/imap", requestMethod: .GET)
            case .getLanguage(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/language", requestMethod: .GET)
            case .getPop(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/pop", requestMethod: .GET)
            case .getVacation(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/vacation", requestMethod: .GET)
            case .updateAutoForwarding(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/autoForwarding", requestMethod: .PUT)
            case .updateImap(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/imap", requestMethod: .PUT)
            case .updateLanguage(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/language", requestMethod: .PUT)
            case .updatePop(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/pop", requestMethod: .PUT)
            case .updateVacation(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/vacation", requestMethod: .PUT)
            }
        }
    }
    
    public enum usersSettingsDelegates {
        case create(userID: String)
        case delete(userID: String, delegateEmail: String)
        case get(userID: String, delegateEmail: String)
        case list(userID: String)
        
        var request: Request {
            switch self {
            case .create(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/delegates", requestMethod: .POST)
            case .delete(userID: let userID, delegateEmail: let delegateEmail):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/delegates/\(delegateEmail)", requestMethod: .DELETE)
            case .get(userID: let userID, delegateEmail: let delegateEmail):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/delegates/\(delegateEmail)", requestMethod: .GET)
            case .list(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/delegates", requestMethod: .GET)
            }
        }
    }
    
    public enum usersSettingsFilters {
        case create(userID: String)
        case delete(userID: String, id: String)
        case get(userID: String, id: String)
        case list(userID: String)
        
        var request: Request {
            switch self {
            case .create(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/filters", requestMethod: .POST)
            case .delete(userID: let userID, id: let id):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/filters/\(id)", requestMethod: .DELETE)
            case .get(userID: let userID, id: let id):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/filters/\(id)", requestMethod: .GET)
            case .list(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/filters", requestMethod: .GET)
            }
        }
    }
    
    public enum usersSettingsForwardingAddresses {
        case create(userID: String)
        case delete(userID: String, forwardingEmail: String)
        case get(userID: String, forwardingEmail: String)
        case list(userID: String)
        
        var request: Request {
            switch self {
            case .create(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/forwardingAddresses", requestMethod: .POST)
            case .delete(userID: let userID, forwardingEmail: let forwardingEmail):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/forwardingAddresses/\(forwardingEmail)", requestMethod: .DELETE)
            case .get(userID: let userID, forwardingEmail: let forwardingEmail):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/forwardingAddresses/\(forwardingEmail)", requestMethod: .GET)
            case .list(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/forwardingAddresses", requestMethod: .GET)
            }
        }
    }
    
    public enum usersSettingsSendAs {
        case create(userID: String)
        case delete(userID: String, sendAsEmail: String)
        case get(userID: String, sendAsEmail: String)
        case list(userID: String)
        case patch(userID: String, sendAsEmail: String)
        case update(userID: String, sendAsEmail: String)
        case verify(userID: String, sendAsEmail: String)
        
        var request: Request {
            switch self {
            case .create(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/sendAs", requestMethod: .POST)
            case .delete(userID: let userID, sendAsEmail: let sendAsEmail):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/sendAs/\(sendAsEmail)", requestMethod: .DELETE)
            case .get(userID: let userID, sendAsEmail: let sendAsEmail):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/sendAs/\(sendAsEmail)", requestMethod: .GET)
            case .list(userID: let userID):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/sendAs", requestMethod: .GET)
            case .patch(userID: let userID, sendAsEmail: let sendAsEmail):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/sendAs/\(sendAsEmail)", requestMethod: .PATCH)
            case .update(userID: let userID, sendAsEmail: let sendAsEmail):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/sendAs/\(sendAsEmail)", requestMethod: .PUT)
            case .verify(userID: let userID, sendAsEmail: let sendAsEmail):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/sendAs/\(sendAsEmail)/verify", requestMethod: .POST)
            }
        }
    }
    
    public enum usersSettingsSendAsSmimeInfo {
        case delete(userID: String, sendAsEmail: String, id: String)
        case get(userID: String, sendAsEmail: String, id: String)
        case insert(userID: String, sendAsEmail: String)
        case list(userID: String, sendAsEmail: String)
        case setDefault(userID: String, sendAsEmail: String, id: String)
        
        var request: Request {
            switch self {
            case .delete(userID: let userID, sendAsEmail: let sendAsEmail, id: let id):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/sendAs/\(sendAsEmail)/smimeInfo/\(id)", requestMethod: .DELETE)
            case .get(userID: let userID, sendAsEmail: let sendAsEmail, id: let id):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/sendAs/\(sendAsEmail)/smimeInfo/\(id)", requestMethod: .GET)
            case .insert(userID: let userID, sendAsEmail: let sendAsEmail):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/sendAs/\(sendAsEmail)/smimeInfo", requestMethod: .POST)
            case .list(userID: let userID, sendAsEmail: let sendAsEmail):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/sendAs/\(sendAsEmail)/smimeInfo", requestMethod: .GET)
            case .setDefault(userID: let userID, sendAsEmail: let sendAsEmail, id: let id):
                return Request(requestURL: "/gmail/v1/users/\(userID)/settings/sendAs/\(sendAsEmail)/smimeInfo/\(id)/setDefault", requestMethod: .POST)
            }
        }
    }
    
    public enum usersThreads {
        case delete(userID: String, id: String)
        case get(userID: String, id: String)
        case list(userID: String, maxResults: Int?, pageToken: String?, query: String?, labelIDs: String?, includeSpamTrash: Bool?)
        case modify(userID: String, id: String)
        case trash(userID: String, id: String)
        case untrash(userID: String, id: String)
        
        var request: Request {
            switch self {
            case .delete(userID: let userID, id: let id):
                return Request(requestURL: "/gmail/v1/users/\(userID)/threads/\(id)", requestMethod: .DELETE)
            case .get(userID: let userID, id: let id):
                return Request(requestURL: "/gmail/v1/users/\(userID)/threads/\(id)", requestMethod: .GET)
            case .list(userID: let userID, maxResults: let maxResults, pageToken: let pageToken, query: let query, labelIDs: let labelIDs, includeSpamTrash: let includeSpamTrash):
                var url: String = "/gmail/v1/users/\(userID)/threads"
                [maxResults, pageToken, query, labelIDs, includeSpamTrash].forEach({ val in
                    if val != nil {
                        if url.contains("?") {
                            url.append("&")
                        } else {
                            url.append("?")
                        }
                        if let child = Mirror(reflecting: val).children.first {
                            url.append("\(child.label! == "query" ? "q" : child.label!)=\(child.value)")
                        }
                    }
                })
                return Request(requestURL: url, requestMethod: .GET)
            case .modify(userID: let userID, id: let id):
                return Request(requestURL: "/gmail/v1/users/\(userID)/threads/\(id)/modify", requestMethod: .POST)
            case .trash(userID: let userID, id: let id):
                return Request(requestURL: "/gmail/v1/users/\(userID)/threads/\(id)/trash", requestMethod: .POST)
            case .untrash(userID: let userID, id: let id):
                return Request(requestURL: "/gmail/v1/users/\(userID)/threads/\(id)/untrash", requestMethod: .POST)
            }
        }
    }
}
