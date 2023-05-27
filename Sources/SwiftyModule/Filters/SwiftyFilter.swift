//
//  File.swift
//  
//
//  Created by Tibor Bodecs on 2021. 12. 21..
//

import Foundation
import FeatherCore
import Vapor
import Splash

extension String {
    
    func replace(_ pattern: String,
                 options: NSRegularExpression.Options = [],
                 collector: ([String]) -> String) -> String
    {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: options) else {
            return self
        }
        let matches = regex.matches(in: self,
                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                    range: NSRange(self.startIndex..., in: self))
        guard matches.count > 0 else {
            return self
        }
        var splitStart = startIndex
        return matches.map { match -> (String, [String]) in
            let range = Range(match.range, in: self)!
            let split = String(self[splitStart ..< range.lowerBound])
            splitStart = range.upperBound
            return (split, (0 ..< match.numberOfRanges)
                .compactMap { Range(match.range(at: $0), in: self) }
                .map { String(self[$0]) }
            )
        }.reduce("") { "\($0)\($1.0)\(collector($1.1))" } + self[Range(matches.last!.range, in: self)!.upperBound ..< endIndex]
    }
    
    func replace(_ regexPattern: String,
                 options: NSRegularExpression.Options = [],
                 collector: @escaping () -> String) -> String
    {
        return self.replace(regexPattern, options: options) { _ in collector() }
    }
}


struct SwiftyFilter: FeatherFilter {

    var key: String { "swifty" }
    var label: String { "Swifty (Splash)" }
    var priority: Int { 100 }

    func filter(_ input: String, _ req: Request) async throws -> String {
        input
            .replace("<pre><code class=\"language-swift\">(.*?)</code></pre>", options: .dotMatchesLineSeparators) { c in
                let highlighter = SyntaxHighlighter(format: HTMLOutputFormat())
                let code = highlighter.highlight(c[1]).trimmingCharacters(in: .whitespacesAndNewlines)
                return "<pre><code class=\"language-swift\">" + code + "</code></pre>"
            }
            .replace("```swift(.*?)```", options: .dotMatchesLineSeparators) { c in
                let highlighter = SyntaxHighlighter(format: HTMLOutputFormat())
                let code = highlighter.highlight(c[1]).trimmingCharacters(in: .whitespacesAndNewlines)
                return "<pre><code class=\"language-swift\">" + code + "</code></pre>"
            }
    }
}
