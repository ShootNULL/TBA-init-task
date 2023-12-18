//
//  MainViewPresenter.swift
//  WorkTask
//
//  Created by Евгений Парфененков on 18.12.2023.
//

import Foundation
import Alamofire


class MainViewPresenter {
        
    func getPhotos() -> [[String]] {
        return [["https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg"],
                ["29.10.2010"], ["Just for test"], ["#test", "#check"]]
    }
    
//    func getPhotos() {
//        // Automatic String to URL conversion, Swift concurrency support, and automatic retry.
//        let response = AF.request("https://api.pinterest.com/v5/pins", interceptor: .retryPolicy)
//                               // Automatic HTTP Basic Auth.
//                               .authenticate(username: "user", password: "pass")
//                               // Caching customization.
//                               .cacheResponse(using: .cache)
//                               // Redirect customization.
//                               .redirect(using: .follow)
//                               // Validate response code and Content-Type.
//                               .validate()
//                               // Produce a cURL command for the request.
//                               .cURLDescription { description in
//                                 print(description)
//                               }
//                               // Automatic Decodable support with background parsing.
//                               // Await the full response with metrics and a parsed body.
//                               .response
//        // Detailed response description for easy debugging.
////        debugPrint(response)
//        print("zhopa", response)
//    }
    
}
