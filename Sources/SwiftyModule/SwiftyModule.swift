//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 21..
//

import Foundation
import FeatherCore
import Vapor

struct SwiftyModule: FeatherModule {
        
    static var bundleUrl: URL? {
        Bundle.module.resourceURL?.appendingPathComponent("Bundle")
    }

    func boot(_ app: Application) throws {
        app.hooks.register(.filters, use: filtersHook)
        app.hooks.register(.webCss, use: webCssHook, priority: 420)
    }

    func webCssHook(args: HookArguments) -> [String] {
        [
            "/css/swifty/swifty.css"
        ]
    }
    
    func filtersHook(args: HookArguments) -> [FeatherFilter] {
        [
            SwiftyFilter()
        ]
    }
    
}
