//
//  WZExtensions.swift
//  Wezr
//
//  Created by Mohamed EL Meseery on 7/17/17.
//  Copyright © 2017 Meseery. All rights reserved.
//

import Foundation

extension Double {
    func KtoF() -> Double {
        return (self * (9/5) - 459.67).rounded()
    }
}

extension Date {
    func dayOfTheWeek ( ) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
}
