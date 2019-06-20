//
//  Resource.swift
//  MVVMTutorial
//
//  Created by iOSDev on 6/17/19.
//  Copyright © 2019 Duch Chamroeurn. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case GET
    case POST
}

struct Resource<T: Codable> {
    let url: URL
    var httpMehtod: HttpMethod = .GET
    var body: Data? = nil
}

extension Resource {
    
    init(url: URL) {
        self.url = url
    }
}
