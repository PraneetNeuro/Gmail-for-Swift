//
//  helpers.swift
//  gmail-client
//
//  Created by Praneet S on 09/04/21.
//

import Foundation
import Combine

extension Encodable {
  public var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}

extension Gmail.UsersMessages {
    
    public static func decodeToMessageList(publisher: AnyPublisher<Data, URLError>) -> AnyPublisher<MessagesList, Error> {
        publisher
            .decode(type: MessagesList.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public static func decodeToMessage(publisher: AnyPublisher<Data, URLError>) -> AnyPublisher<Message, Error> {
        publisher
            .decode(type: Message.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}

extension Gmail.UsersThreads {
    
    public static func decodeToThread(publisher: AnyPublisher<Data, URLError>) -> AnyPublisher<Thread, Error> {
        publisher
            .decode(type: Thread.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public static func decodeToThreadList(publisher: AnyPublisher<Data, URLError>) -> AnyPublisher<ThreadList, Error> {
        publisher
            .decode(type: ThreadList.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

}

extension Gmail.UsersLabels {
    
    public static func decodeToLabel(publisher: AnyPublisher<Data, URLError>) -> AnyPublisher<Label, Error> {
        publisher
            .decode(type: Label.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public static func decodeToLabelList(publisher: AnyPublisher<Data, URLError>) -> AnyPublisher<LabelList, Error> {
        publisher
            .decode(type: LabelList.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}

extension Gmail.UsersSettings {
    
    public static func decodeToAutoForwarding(publisher: AnyPublisher<Data, URLError>) -> AnyPublisher<AutoForwarding, Error> {
        publisher
            .decode(type: AutoForwarding.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public static func decodeToImapSetttings(publisher: AnyPublisher<Data, URLError>) -> AnyPublisher<ImapSettings, Error> {
        publisher
            .decode(type: ImapSettings.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public static func decodeToLanguageSettings(publisher: AnyPublisher<Data, URLError>) -> AnyPublisher<LanguageSettings, Error> {
        publisher
            .decode(type: LanguageSettings.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    public static func decodeToPopSettings(publisher: AnyPublisher<Data, URLError>) -> AnyPublisher<PopSettings, Error> {
        publisher
            .decode(type: PopSettings.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
