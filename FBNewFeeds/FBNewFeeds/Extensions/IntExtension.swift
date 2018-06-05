//
//  IntExtension.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 6/1/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import Foundation

extension Int {

    var abbreviated: String {
        let abbrev = "KMBTPE"
        return abbrev.enumerated().reversed().reduce(nil as String?) { accum, tuple in
            let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
            let format = (factor.truncatingRemainder(dividingBy: 1)  == 0 ? "%.0f%@" : "%.1f%@")
            return accum ?? (factor > 1 ? String(format: format, factor, String(tuple.1)) : nil)
        } ?? String(self)
    }

}
