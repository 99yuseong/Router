//
//  Router.swift
//  Router
//
//  Created by 남유성 on 6/24/24.
//

import SwiftUI

@Observable
final class Router {
    static let shared = Router()
    // MARK: - 싱글톤 VS 필요한 곳에서 선언
    private init() {}
    
    private var _root = AnyRoutable(Root.root)
    private var _pushablePath: [AnyRoutable] = []
    @ObservationIgnored private var _presentablePath: [AnyRoutable] = []
}

extension Router {
    public func push(to routeType: any Routable) {
        _pushablePath.append(AnyRoutable(routeType))
    }
    
    public func push(to routeTypes: [any Routable]) {
        _pushablePath.append(contentsOf: routeTypes.map { AnyRoutable($0) })
    }
    
    public func pop() {
        _pushablePath.removeLast()
    }
    
    public func popToRoot() {
        _pushablePath = []
    }
    
    public func popToRoot(of routeType: RouteType) {
        guard let lastIndex = _pushablePath.firstIndex(where: { $0.type == routeType })
        else { return }
        
        _pushablePath.removeLast(_pushablePath.count - (lastIndex + 1))
    }
    
    public func endRoute(of routeType: RouteType) {
        guard let lastIndex = _pushablePath.firstIndex(where: { $0.type == routeType })
        else { return }
        
        _pushablePath.removeLast(_pushablePath.count - lastIndex)
    }
}

extension Router {
    public func sheet(
        to routeType: any Routable,
        detents: Set<PresentationDetent> = [.large],
        indicatorVisibility: Visibility = .hidden,
        onDismiss: (() -> Void)? = nil
    ) {
        let routable = AnyRoutable(
            routeType,
            style: .sheet(detents, indicatorVisibility),
            onDismiss: { [weak self] in
                self?._presentablePath.removeLast()
                onDismiss?()
            }
        )
        
        if _pushablePath.isEmpty && _presentablePath.isEmpty {
            _root.sheetItem = routable
        } else if _presentablePath.isEmpty {
            _pushablePath.last?.sheetItem = routable
        } else {
            _presentablePath.last?.sheetItem = routable
        }
        _presentablePath.append(routable)
    }
    
    public func fullScreenCover(
        to routeType: any Routable,
        onDismiss: (() -> Void)? = nil
    ) {
        let routable = AnyRoutable(
            routeType,
            style: .cover,
            onDismiss: { [weak self] in
                self?._presentablePath.removeLast()
                onDismiss?()
            }
        )
        
        if _pushablePath.isEmpty && _presentablePath.isEmpty {
            _root.fullCoverItem = routable
        } else if _presentablePath.isEmpty {
            _pushablePath.last?.fullCoverItem = routable
        } else {
            _presentablePath.last?.fullCoverItem = routable
        }
        
        _presentablePath.append(routable)
    }
    
    public func dismiss() {
        if _presentablePath.count > 1 {
            let count = _presentablePath.count
            _presentablePath[count - 2].sheetItem = nil
            _presentablePath[count - 2].fullCoverItem = nil
        } else if _pushablePath.isEmpty {
            _root.sheetItem = nil
            _root.fullCoverItem = nil
        } else {
            _pushablePath.last?.sheetItem = nil
            _pushablePath.last?.fullCoverItem = nil
        }
    }
}

extension Router {
    @ViewBuilder
    public func Stack<Root: View>(_ root: @escaping () -> Root) -> some View {
        RouterStack(
            router: self,
            content: root
        )
    }
    
    struct RouterStack<Content>: View where Content: View {
        @Bindable var router: Router
        private let content: () -> Content
        
        init(
            router: Router,
            @ViewBuilder content: @escaping () -> Content
        ) {
            self.router = router
            self.content = content
        }

        var body: some View {
            NavigationStack(path: $router._pushablePath) {
                AnyRoutableView(route: Bindable(router._root)) {
                    content()
                }
                .navigationDestination(for: AnyRoutable.self) { route in
                    AnyRoutableView(route: Bindable(route)) {
                        route.NavigatingView()
                    }
                }
            }
        }
    }
}

extension Router {
    public var description: String {
        _pushablePath.isEmpty ?
        "Root" :
        "Root -> " + _pushablePath.map { $0.description }.joined(separator: " -> ")
    }
}
