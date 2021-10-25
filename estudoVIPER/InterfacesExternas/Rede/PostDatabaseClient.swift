//
//  PostDatabaseClient.swift
//  estudoVIPER
//
//  Created by Roberto Edgar Geiss on 30/09/21.
//

import Foundation

protocol JSONDictionaryInitializable
{
    init?(json: [String:Any])
}

struct PostDatabaseAssumption
{
    static let calendar = Calendar(identifier: .iso8601)
    static let timeZone = TimeZone(secondsFromGMT: 0)
    static let locale = Locale(identifier: "en_US_POSIX")
    
    static let ymdDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        df.locale = Self.locale
        df.timeZone = Self.timeZone
        df.calendar = Self.calendar
        return df
    }()
}

//struct PostDatabaseDiscoveryResult : PostSummaryResult, JSONDictionaryInitializable
//{
//    var pageNumber: UInt?
//    var totalResults: UInt?
//    var totalPages: UInt?
//    var results: [PostSummary]?
//    
//    init?(json: [String:Any])
//    {
//        pageNumber = json["page"] as? UInt
//        totalResults = json["total_results"] as? UInt
//        totalPages = json["total_pages"] as? UInt
//        if let resultsList = json["results"] as? [[String:Any]]
//        {
//            results = resultsList.compactMap({PostDatabasePostSummary(json: $0)})
//        }
//    }
//}


//struct PostDatabasePostSummary: PostSummary, JSONDictionaryInitializable
//{
//
//    var id: Int?
//    var title: String?
//    var body: String?
//    var userIdentifier: Int?
//
//    init?(json: [String:Any])
//    {
//        guard let id1 = json["id"] as? Int
//        else {
//            return nil
//        }
//
//        id = PostDatabasePostIdentifier(rawValue: id!)
//        title = json["original_title"] as? String
//        body = json["original_language"] as? String
//        userIdentifier = json["original_language"] as? Int
//    }
//}
//
//
//struct PostDatabasePostIdentifier: PostIdentifier, Equatable
//{
//
//    var rawValue: Int?
//
//}

//struct PostDatabasePostDetail: PostDetail, JSONDictionaryInitializable
//{
//    var id: Int?
//    var title: String?
//    var body: String?
//    var userIdentifier: Int?
//    var PostID: PostIdentifier
//
//    init?(json: [String : Any])
//    {
//        guard let id = json["id"] as? UInt64
//        else {
//            return nil
//        }
//        PostID = PostDatabasePostIdentifier(rawValue: id)
//        title = json["original_title"] as? String
//        body = json["original_language"] as? String
//        userIdentifier = json["original_language"] as? Int
//
//        if let runtimeValue = json["runtime"] as? Float {
//            runtime = TimeInterval(runtimeValue * 60)
//        }
//    }
//}
//
//class PostDatabaseClient: PostDataProvider
//{
//    static let networkSubsystem = NetworkSubsystem.defaultInstance
//
//    let jsonQueue: DispatchQueue
//    let resultQueue: DispatchQueue
//
//    init()
//    {
//        let subsystem = type(of: self).networkSubsystem
//        jsonQueue = DispatchQueue(label:"PostDatabaseClient-JSON",qos: .default, target:subsystem.jsonQueue)
//        resultQueue = DispatchQueue(label:"PostDatabaseClient-Result",qos: .userInitiated, target:subsystem.resultQueue)
//    }
//
//    var apiKey = "900a1c8214b1686a76c5fd0f50150be0"
//
//    lazy var urlSession = URLSession(configuration: configuration)
//
//    var baseURL: URL
//    {
//        get
//        {
//            URL(string: "https://jsonplaceholder.typicode.com/posts")!
//        }
//    }
//
//    var configuration: URLSessionConfiguration
//    {
//        get
//        {
//            URLSessionConfiguration.default
//        }
//    }
//
//    func makeRequest(path: String, queryItems items: [URLQueryItem]) -> URLRequest
//    {
//        var queryItems = items
//        let url = baseURL.appendingPathComponent(path)
//        queryItems.append(URLQueryItem(name:"api_key", value:apiKey))
//        var urlComps = URLComponents(url: url, resolvingAgainstBaseURL: true)!
//        urlComps.queryItems = queryItems
//        var request = URLRequest(url: urlComps.url!, cachePolicy: .returnCacheDataElseLoad)
//        request.setValue("application/json", forHTTPHeaderField: "Accept")
//        request.networkServiceType = .responsiveData
//        return request
//    }
//
//    func getJSONDictionary(request: URLRequest, successHandler: @escaping (Dictionary<String,Any>) -> Void, failureHandler: @escaping(Error?) -> Void)
//    {
//        let task = urlSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
//            guard let receivedResponse = response as? HTTPURLResponse
//            else {
//                failureHandler(error)
//                return
//            }
//            guard let statusCode = HTTPStatusCode(rawValue: receivedResponse.statusCode)
//            else {
//                failureHandler(error)
//                return
//            }
//            guard statusCode.isGood()
//            else {
//                failureHandler(NSError(code: statusCode))
//                return
//            }
//            guard let receivedData = data
//            else {
//                failureHandler(NSError(code: .noData))
//                return
//            }
//            self.jsonQueue.async {
//                guard let jsonDict = try? JSONSerialization.jsonObject(with: receivedData, options: []) as? Dictionary<String,Any>
//                else {
//                    failureHandler(NSError(code: .dataParseError))
//                    return
//                }
//                successHandler(jsonDict)
//            }
//        }
//        task.resume()
//    }
//
//    func getJSONObject<ObjectImplementation, ObjectInterface>(request: URLRequest, concreteObject: ObjectImplementation.Type, resultReceiver: @escaping (Result<ObjectInterface>) -> Void) where ObjectImplementation: JSONDictionaryInitializable
//    {
//        let returnError = {
//            (error: Error?) in
//            self.resultQueue.async {
//                resultReceiver(Result(error: error))
//            }
//        }
//        getJSONDictionary(request: request, successHandler: { (jsonDict) in
//            guard let result = ObjectImplementation.init(json: jsonDict)
//            else {
//                returnError(NSError(code: .dataParseError))
//                return
//            }
//            guard let resultInterface = result as? ObjectInterface
//            else {
//                returnError(NSError(code: .internalError))
//                return
//            }
//            self.resultQueue.async {
//                resultReceiver(.success(resultInterface))
//            }
//        }, failureHandler: returnError)
//
//    }
//
//    // MARK: - PostDataProvider
//
//    var defaultPageSize: Int
//    {
//        get {20}
//    }
//
////    func fetchPostSummaries(filter: [(attribute: PostFilterAttribute, value: Any, isAscending: Bool)], sort: (attribute: PostSortAttribute, isAscending: Bool)?, pageNumber: Int?, resultReceiver: @escaping (Result<PostSummaryResult>) -> Void)
////    {
////        var queryItems = [URLQueryItem]()
////        queryItems.reserveCapacity(filter.count + 2)
////        for filterEntry in filter {
////            switch filterEntry.attribute {
////            case .isAdult:
////                queryItems.append(.init(name: "include_adult", value: (filterEntry.value as? Bool ?? false) ? "true" : "false"))
////            case .language:
////                if let language = filterEntry.value as? String {
////                    queryItems.append(.init(name: "language", value: language))
////                }
////            case .releaseDate:
////                if let dateStr = formatYMD(dateValue: filterEntry.value) {
////                    let filterName = filterEntry.isAscending ? "release_date.lte" : "release_date.gte"
////                    queryItems.append(.init(name: filterName, value: dateStr))
////                }
////            }
////        }
////        if let page = pageNumber {
////            queryItems.append(URLQueryItem(name:"page", value:"\(page)"))
////        }
////        let request = makeRequest(path:"discover/Post", queryItems: queryItems)
////        getJSONObject(request: request, concreteObject: PostDatabaseDiscoveryResult.self, resultReceiver: resultReceiver)
////    }
//
//    func fetchPostDetail(PostID: PostIdentifier, resultReceiver: @escaping (Result<PostDetail>) -> Void)
//    {
//        let idValue = PostID as! PostDatabasePostIdentifier
//        let request = makeRequest(path:"Post/\(idValue.rawValue)", queryItems: [])
//        getJSONObject(request: request, concreteObject: PostDatabasePostDetail.self, resultReceiver: resultReceiver)
//    }
//}







