//
//  Router.swift
//  PushRouter
//
//  Created by 남유성 on 6/25/24.
//

import Foundation

import SwiftUI

@Observable
final class Router {
    static let shared = Router()
    private init() {}
    
    private var _path: [AnyRoutable] = []
}

extension Router {
    public func push(to routeType: any Routable) {
        _path.append(AnyRoutable(routeType))
    }
    
    public func push(to routeTypes: [any Routable]) {
        _path.append(contentsOf: routeTypes.map { AnyRoutable($0) })
    }
    
    public func pop() {
        _path.removeLast()
    }
    
    public func popToRoot() {
        _path = []
    }
    
    public func popToRoot(of routeType: RouteType) {
        guard let lastIndex = _path.firstIndex(where: { $0.type == routeType })
        else { return }
        
        _path.removeLast(_path.count - (lastIndex + 1))
    }
    
    public func endRoute(of routeType: RouteType) {
        guard let lastIndex = _path.firstIndex(where: { $0.type == routeType })
        else { return }
        
        _path.removeLast(_path.count - lastIndex)
    }
}

extension Router {
    @ViewBuilder
    public func Stack<Root: View>(_ root: @escaping () -> Root) -> some View {
        RouterStack(
            path: Bindable(self)._path,
            content: root
        )
    }
    
    struct RouterStack<Content>: View where Content: View {
        @Binding private var path: [AnyRoutable]
        private let content: () -> Content
        
        init(
            path: Binding<[AnyRoutable]>,
            @ViewBuilder content: @escaping () -> Content
        ) {
            self._path = path
            self.content = content
        }

        var body: some View {
            NavigationStack(path: $path) {
                content()
                    .navigationDestination(for: AnyRoutable.self) { route in
                        route.NavigatingView()
                    }
            }
        }
    }
}

extension Router {
    public var curRouteDescription: String {
        _path.last?.description ?? "Root"
    }
    
    public var stackDescription: String {
        var components = ["Root"]
        
        if !pathDescription.isEmpty {
            components.append(pathDescription)
        }
        
        return components.joined(separator: " -> ")
    }
    
    private var pathDescription: String {
        _path
            .map { $0.description }
            .joined(separator: " -> ")
    }
}
