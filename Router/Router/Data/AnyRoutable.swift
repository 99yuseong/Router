//
//  AnyRoutable.swift
//  Router
//
//  Created by 남유성 on 6/24/24.
//

import SwiftUI

@Observable
class AnyRoutable: Routable, Identifiable {
    var sheetItem: AnyRoutable?
    var fullCoverItem: AnyRoutable?
    
    @ObservationIgnored internal let id: UUID
    @ObservationIgnored let type: RouteType
    @ObservationIgnored let style: RouteStyle
    @ObservationIgnored let description: String
    @ObservationIgnored var onDismiss: (() -> Void)?
    @ObservationIgnored private let _NavigatingView: () -> any View
    
    @ViewBuilder func NavigatingView() -> AnyView {
        AnyView(_NavigatingView())
    }
    
    public init<T: Routable>(
        _ wrapped: T,
        style: RouteStyle = .push,
        onDismiss: (() -> Void)? = nil
    ) {
        self.id = UUID()
        self.type = wrapped.type
        self.style = style
        self.description = wrapped.description
        self._NavigatingView = wrapped.NavigatingView
        self.onDismiss = onDismiss
    }
    
    public func clearItem() {
        sheetItem = nil
        fullCoverItem = nil
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

