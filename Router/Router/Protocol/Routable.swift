//
//  Routable.swift
//  Router
//
//  Created by 남유성 on 6/24/24.
//

import SwiftUI

protocol Routable: Hashable, CustomStringConvertible {
    associatedtype V: View
    
    var type: RouteType { get }
    var root: any Routable { get }
    var description: String { get }
    
    func NavigatingView() -> V
}

