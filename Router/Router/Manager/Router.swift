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
    
    private init() {
        let root = AnyRoutable(Root.root)
        self._root = root
        self._curRoute = root
    }
    
    private var _root: AnyRoutable
    private var _pushStack: [AnyRoutable] = []
    @ObservationIgnored private var _curRoute: AnyRoutable
    @ObservationIgnored private var _presentStack: [AnyRoutable] = []
}

extension Router {
    public func push(to routeType: any Routable) {
        let route = AnyRoutable(routeType)
        _pushStack.append(route)
        _curRoute = route
    }
    
    public func push(to routeTypes: [any Routable]) {
        guard !routeTypes.isEmpty else { return }
        
        let routes = routeTypes.map { AnyRoutable($0) }
        _pushStack.append(contentsOf: routes)
        _curRoute = routes.last ?? _root
    }
    
    public func pop() {
        _pushStack.removeLast()
        _curRoute = _pushStack.last ?? _root
    }
    
    public func popToRoot() {
        _pushStack = []
        _curRoute = _root
    }
    
    public func popToRoot(of routeType: RouteType) {
        guard let lastIndex = _pushStack.firstIndex(where: { $0.type == routeType })
        else { return }
        
        _pushStack.removeLast(_pushStack.count - (lastIndex + 1))
        _curRoute = _pushStack.last ?? _root
    }
    
    public func endRoute(of routeType: RouteType) {
        guard let lastIndex = _pushStack.firstIndex(where: { $0.type == routeType })
        else { return }
        
        _pushStack.removeLast(_pushStack.count - lastIndex)
        _curRoute = _pushStack.last ?? _root
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
                self?._presentStack.removeLast()
                onDismiss?()
            }
        )
        
        presentableRoute?.sheetItem = routable
        _presentStack.append(routable)
        _curRoute = _presentStack.last ?? _root
    }
    
    public func fullScreenCover(
        to routeType: any Routable,
        onDismiss: (() -> Void)? = nil
    ) {
        let routable = AnyRoutable(
            routeType,
            style: .cover,
            onDismiss: { [weak self] in
                self?._presentStack.removeLast()
                onDismiss?()
            }
        )
        
        presentableRoute?.fullCoverItem = routable
        _presentStack.append(routable)
        _curRoute = _presentStack.last ?? _root
    }
    
    public func dismiss() {
        if _presentStack.count > 1 {
            let count = _presentStack.count
            _presentStack[count - 2].clearItem()
            _curRoute = _presentStack[count - 2]
            
        } else if _pushStack.isEmpty {
            _root.clearItem()
            _curRoute = _root
            
        } else {
            _pushStack.last?.clearItem()
            _curRoute = _pushStack.last ?? _root
        }
    }
    
    private var presentableRoute: AnyRoutable? {
        if _pushStack.isEmpty && _presentStack.isEmpty {
            _root
        } else if _presentStack.isEmpty {
            _pushStack.last
        } else {
            _presentStack.last
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
            NavigationStack(path: $router._pushStack) {
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
    public var curRouteDescription: String {
        _curRoute.description
    }
    
    public var stackDescription: String {
        var components = ["Root"]
        
        if !pushStackDescription.isEmpty {
            components.append(pushStackDescription)
        }
        
        if !presentStackDescription.isEmpty {
            components.append(presentStackDescription)
        }
                
        return components.joined(separator: " -> ")
    }
    
    private var pushStackDescription: String {
        _pushStack
            .map { $0.description }
            .joined(separator: " -> ")
    }
    
    private var presentStackDescription: String {
        _presentStack
            .map { "(\($0.style.description)) \($0.description)" }
            .joined(separator: " -> ")
    }
}
