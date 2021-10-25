//
//  Protocolos.swift
//  estudoVIPER
//
//  Created by Roberto Edgar Geiss on 30/09/21.
//
// MARK: - User Interface

// MARK: Routers

import UIKit

public protocol PostBrowserWireframe: AnyObject
{
    var rootViewController: UIViewController { get }
    func present(PostDetail: PostDetailPresenter, from: UIViewController)
    func present(error: Error, from sourceVC: UIViewController, retryHandler: (() -> Void)? )
}

//public func createPostBrowserWireframe(dataProvider: PostDataProvider) -> PostBrowserWireframe
//{
//    PostBrowserWireframeImp(dataProvider: dataProvider)
//}

// MARK: PostListPresenter

public protocol PostListPresenter: AnyObject {
    var output: PostListPresenterOutput? {get set}
    var numberOfItems: Int { get }
    func configureCell(_ cell: PostSummaryCell, forItemAt: Int)
    func loadInitialItems()
    func loadMoreItems()
    func showDetailOfItem(at indexPath: Int)
    var loadBatchSize: Int { get set }
}


public protocol PostListPresenterOutput: UIViewController
{
    func presenter(_ presenter: PostListPresenter, didAddItemsAt indexes: IndexSet)
}

// MARK: PostDetailPresenter

public protocol PostDetailPresenter: AnyObject {
    var output: PostDetailPresenterOutput? {get set}
    var hasDetail: Bool { get }
    
    var PostTitleText: String? { get }
    var PostRuntimeText: String? { get }
    var PostTaglineText: String? { get }
    var PostReleaseDateText: String? { get }
    
    func refreshDetail()
}


public protocol PostDetailPresenterOutput: UIViewController {
    func presenterDidUpdatePostDetail(_ presenter: PostDetailPresenter)
}



// MARK: Views

public protocol PostSummaryCell: AnyObject
{
    var PostID: PostIdentifier? {get set}
    func setPostOriginalTitle(_ title: String?)
}


// MARK: View Controllers


protocol DetailViewController: UIViewController {
    var isEmpty: Bool { get }
}


// MARK: - Network


// MARK: Data Provider
public protocol PostSummaryResult
{
    var pageNumber: UInt? { get }
    var totalResults: UInt? { get }
    var totalPages: UInt? { get }
    var results: [PostSummary]? { get }
}


public protocol PostDataProvider
{
    var defaultPageSize: Int { get }
    func fetchPostSummaries(
        filter: [(attribute: PostFilterAttribute, value: Any, isAscending: Bool)],
        sort: (attribute: PostSortAttribute, isAscending: Bool)?,
        pageNumber: Int?,
        resultReceiver: @escaping ( _ : Result<PostSummaryResult, Error> ) -> Void )
    
    func fetchPostDetail(PostID: PostIdentifier, resultReceiver: @escaping (Result<PostDetail, Error>) -> Void)
}

