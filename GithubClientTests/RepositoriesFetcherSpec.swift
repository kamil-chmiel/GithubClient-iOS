//
//  RepositoriesFetcherSpec.swift
//  GithubClientTests
//
//  Created by Kamil Chmiel on 01.05.2018.
//  Copyright © 2018 Kamil Chmiel. All rights reserved.
//

import Quick
import Nimble
import Swinject
@testable import GithubClient

class RepositoriesFetcherSpec: QuickSpec {
    
    struct StubNetwork: Networking {
        private static let json =
            "[" +
                "{" +
                    "\"id\": 123493935," +
                    "\"name\": \"Calculator\"," +
                    "\"description\": \"Just a simple calculator.\"," +
                    "\"private\": false," +
                    "\"created_at\": \"2018-03-11T13:36:48Z\"," +
                    "\"updated_at\": \"2018-04-17T06:46:22Z\"," +
                    "\"pushed_at\": \"2018-04-17T06:46:21Z\"," +
                    "\"size\": 4092," +
                    "\"language\": \"Swift\"," +
                    "\"license\": null," +
                "}," +
                "{" +
                    "\"id\": 123493425," +
                    "\"name\": \"TransApp\"," +
                    "\"description\": \"Helps managing human resources in transport company.\"," +
                    "\"private\": false," +
                    "\"created_at\": \"2014-03-11T13:36:48Z\"," +
                    "\"updated_at\": \"2014-04-17T07:46:22Z\"," +
                    "\"pushed_at\": \"2014-04-17T03:46:21Z\"," +
                    "\"size\": 0," +
                    "\"language\": \"Python\"," +
                    "\"license\": \"CC BY 3.0\"," +
                "}" +
            "]"
        func request(response: @escaping (NSData?) -> ()) {
            let data = StubNetwork.json.data(
                using: String.Encoding.utf8, allowLossyConversion: false)
            response((data! as NSData))
        }
    }
    
    override func spec() {
        var container: Container!
        beforeEach {
            container = Container()
            
            // Registration for the network using Alamofire
            container.register(Networking.self) { _ in Network() }
            container.register(RepositoriesFetcher.self) { r in
                RepositoriesFetcher(networking: r.resolve(Networking.self)!)
            }
            
            // Registration for the stub network
            container.register(Networking.self, name: "stub") { _ in
                StubNetwork()
            }
            container.register(RepositoriesFetcher.self, name: "stub") { r in
                RepositoriesFetcher(networking: r.resolve(Networking.self, name: "stub")!)
            }
        }
        
        // testing if request return some data
        it("returns repositories.") {
            var repositories: [Repository]?
            let fetcher = container.resolve(RepositoriesFetcher.self)!
            fetcher.fetch { repositories = $0 }
            
            expect(repositories).toEventuallyNot(beNil())
            expect(repositories?.count).toEventually(beGreaterThan(0))
        }
        
        // testing data mapping using mockup
        it("fills repositories data.") {
            var repositories: [Repository]?
            let fetcher = container.resolve(RepositoriesFetcher.self, name: "stub")!
            fetcher.fetch { repositories = $0 }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssX"
            
            expect(repositories?[0].id).toEventually(equal(123493935))
            expect(repositories?[0].title).toEventually(equal("Calculator"))
            expect(repositories?[0].description).toEventually(equal("Just a simple calculator."))
            expect(repositories?[0].privacy).toEventually(equal(false))
            expect(repositories?[0].created).toEventually(equal(dateFormatter.date(from: "2018-03-11T13:36:48Z")))
            expect(repositories?[0].updated).toEventually(equal(dateFormatter.date(from: "2018-04-17T06:46:22Z")))
            expect(repositories?[0].pushed).toEventually(equal(dateFormatter.date(from: "2018-04-17T06:46:21Z")))
            expect(repositories?[0].size).toEventually(equal(4092))
            expect(repositories?[0].language).toEventually(equal("Swift"))
            expect(repositories?[0].license).toEventually(equal("None"))
            
            expect(repositories?[1].id).toEventually(equal(123493425))
            expect(repositories?[1].title).toEventually(equal("TransApp"))
            expect(repositories?[1].description).toEventually(equal("Helps managing human resources in transport company."))
            expect(repositories?[1].privacy).toEventually(equal(false))
            expect(repositories?[1].created).toEventually(equal(dateFormatter.date(from: "2014-03-11T13:36:48Z")))
            expect(repositories?[1].updated).toEventually(equal(dateFormatter.date(from: "2014-04-17T07:46:22Z")))
            expect(repositories?[1].pushed).toEventually(equal(dateFormatter.date(from: "2014-04-17T03:46:21Z")))
            expect(repositories?[1].size).toEventually(equal(0))
            expect(repositories?[1].language).toEventually(equal("Python"))
            expect(repositories?[1].license).toEventually(equal("CC BY 3.0"))
        }
    }
    
    
}
