import Foundation

class Gmail {
    
    static var bearerToken: String?
    
    func setAuth(bearerToken: String) {
        Gmail.bearerToken = bearerToken
    }
    
    class Users {
        
        static func getProfile(userID: String) -> Data? {
            return API.executeRequest(APIRequest: API.user.getProfile(userID: userID).request, headers: ["Authorization" : "Bearer "], requestBody: nil)
        }
        
        static func stop(userID: String) -> Data? {
            return API.executeRequest(APIRequest: API.user.stop(userID: userID).request, headers: ["Authorization" : "Bearer "], requestBody: nil)
        }
        
        static func watch(userID: String, requestBody: [String : Any]) -> Data? {
            return API.executeRequest(APIRequest: API.user.watch(userID: userID).request, headers: ["Authorization" : "Bearer "], requestBody: requestBody)
        }
        
    }
    
    class UsersDrafts {
        
        static func create(userID: String, type: API.resourceContentType, requestBody: [String : Any]) -> Data? {
            return API.executeRequest(APIRequest: API.usersDrafts.create(userId: userID, type: type).request, headers: ["Authorization" : "Bearer "], requestBody: requestBody)
        }
        
        static func delete(userID: String, id: String) -> Data? {
            return API.executeRequest(APIRequest: API.usersDrafts.delete(userId: userID, id: id).request, headers: ["Authorization" : "Bearer "], requestBody: nil)
        }
        
        static func get(userID: String, id: String) -> Data? {
            return API.executeRequest(APIRequest: API.usersDrafts.get(userId: userID, id: id).request, headers: ["Authorization" : "Bearer "], requestBody: nil)
        }
    }
    
}
