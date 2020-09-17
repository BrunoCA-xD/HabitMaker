//
//  Localizable.swift
//  HabitMaker
//
//  Created by Bruno Cardoso Ambrosio on 16/09/20.
//  Copyright © 2020 Bruno Cardoso Ambrosio. All rights reserved.
//

import Foundation

protocol Localizable: RawRepresentable {
    func localized(_ args: [CVarArg]) -> String
    func localizedHTML(_ args: [CVarArg]) -> NSAttributedString?
}

extension Localizable where Self.RawValue == String {
    private var localizedString: String {
        return NSLocalizedString(rawValue, comment: "")
    }
    
    func localized(_ args: [CVarArg] = []) -> String {
        return args.isEmpty ? localizedString : String(format: localizedString, arguments: args)
    }
    
    func localizedHTML(_ args: [CVarArg] = []) -> NSAttributedString? {
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] =
            [.documentType: NSAttributedString.DocumentType.html,
             .characterEncoding: String.Encoding.utf8.rawValue]
        let text = localized(args)
        let data = Data(text.utf8)
        return try? NSAttributedString(data: data, options: options, documentAttributes: nil)
    }
}
