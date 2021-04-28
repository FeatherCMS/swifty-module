//
//  main.swift
//  Feather
//
//  Created by Tibor Bodecs on 2019. 12. 17..
//

import FeatherCore
import SwiftyModule

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)
let app = Application(env)
defer { app.shutdown() }

Feather.useSQLiteDatabase(app)
Feather.useLocalFileStorage(app)

app.feather.use([
    SwiftyBuilder().build()
])

if app.isDebug {
    try Feather.resetPublicFiles(app)
    try Feather.copyTemplatesIfNeeded(app)
}


try Feather.boot(app)

try app.run()

