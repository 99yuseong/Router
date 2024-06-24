//
//  AnyRoutable.swift
//  Router
//
//  Created by 남유성 on 6/24/24.
//

import SwiftUI

struct AnyRoutable: Routable, Identifiable {
    private let _type: RouteType
    private let _root: any Routable
    private let _description: String
    private let _NavigatingView: () -> any View
    
    init<T: Routable>(_ wrapped: T) {
        id = UUID()
        _type = wrapped.type
        _root = wrapped.root
        _description = wrapped.description
        _NavigatingView = wrapped.NavigatingView
    }
    
    internal let id: UUID
    var type: RouteType { _type }
    var root: any Routable { _root }
    var description: String { _description }

    @ViewBuilder func NavigatingView() -> some View {
        AnyView(_NavigatingView())
    }
}

extension AnyRoutable {
    static func == (lhs: AnyRoutable, rhs: AnyRoutable) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

