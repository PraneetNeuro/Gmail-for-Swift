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
        
    }
}
