//
//  Routable.swift
//  PushRouter
//
//  Created by 남유성 on 6/25/24.
//

import SwiftUI

protocol Routable: Hashable, CustomStringConvertible {
    associatedtype V: View
    
    var type: RouteType { get }
    var description: String { get }
    
    func NavigatingView() -> V
}

