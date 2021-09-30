//
//  Interfaces.swift
//  estudoVIPER
//
//  Created by Roberto Edgar Geiss on 30/09/21.
//

import Foundation
//public func makeMovieDatabaseClient() -> MovieDataProvider {
//    return MovieDatabaseClient()
//}

// MARK: Network Errors

public enum NetworkErrorCode: Int
{
    case noError
    case internalError
    case unknownHTTPStatusCode
    case noData
    case dataParseError
    case dataFormatError
    case missingFieldError
}




// MARK: HTTP Status

public enum HTTPStatusCode: Int
{
    // 100 Informational
    case `continue` = 100
    case switchingProtocols
    case processing
    // 200 Success
    case okay = 200
    case created
    case accepted
    case nonAuthoritativeInformation
    case noContent
    case resetContent
    case partialContent
    case multiStatus
    case alreadyReported
    case instanceManipulationUsed = 226
    // 300 Redirection
    case multipleChoices = 300
    case movedPermanently
    case found
    case seeOther
    case notModified
    case useProxy
    case switchProxy
    case temporaryRedirect
    case permanentRedirect
    // 400 Client Error
    case badRequest = 400
    case unauthorized
    case paymentRequired
    case forbidden
    case notFound
    case methodNotAllowed
    case notAcceptable
    case proxyAuthenticationRequired
    case requestTimeout
    case conflict
    case gone
    case lengthRequired
    case preconditionFailed
    case payloadTooLarge
    case URITooLong
    case unsupportedMediaType
    case rangeNotSatisfiable
    case expectationFailed
    case imATeapot
    case misdirectedRequest = 421
    case unprocessableEntity
    case locked
    case failedDependency
    case upgradeRequired = 426
    case preconditionRequired = 428
    case tooManyRequests
    case requestHeaderFieldsTooLarge = 431
    case unavailableForLegalReasons = 451
    // 500 Server Error
    case internalServerError = 500
    case notImplemented
    case badGateway
    case serviceUnavailable
    case gatewayTimeout
    case versionNotSupported
    case variantAlsoNegotiates
    case insufficientStorage
    case loopDetected
    case notExtended = 510
    case networkAuthenticationRequired
    
    public func isGood() -> Bool
    {
        !(rawValue >= 400 && rawValue < 600)
    }
}

public let HTTPStatusErrorDomain = ""
public let NetworkErrorDomain = ""

public extension NSError
{
    convenience init(code: HTTPStatusCode, userInfo: [String : Any]? = nil)
    {
        self.init(domain: HTTPStatusErrorDomain, code: code.rawValue, userInfo: userInfo)
    }
}

public extension NSError
{
    convenience init(code: NetworkErrorCode, userInfo: [String : Any]? = nil)
    {
        self.init(domain: NetworkErrorDomain, code: code.rawValue, userInfo: userInfo)
    }
}
