//
//  AnyRoutable.swift
//  PushRouter
//
//  Created by 남유성 on 6/25/24.
//

import SwiftUI

struct AnyRoutable: Routable, Identifiable {
    internal let id: UUID
    
    public let type: RouteType
    public let description: String
    
    private let _NavigatingView: () -> any View
    
    init<T: Routable>(_ wrapped: T) {
        id = UUID()
        type = wrapped.type
        description = wrapped.description
        _NavigatingView = wrapped.NavigatingView
    }

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
