//
//  AnyRoutableView.swift
//  Router
//
//  Created by 남유성 on 6/24/24.
//

import SwiftUI

struct AnyRoutableView<Content>: View where Content: View {
    @Bindable var route: AnyRoutable
    let content: () -> Content
    
    init(
        route: Bindable<AnyRoutable>,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._route = route
        self.content = content
    }
    
    var body: some View {
        Group {
            content()
        }
        .sheet(
            item: $route.sheetItem,
            onDismiss: $route.sheetItem.wrappedValue?.onDismiss,
            content: { route in
                if case let .sheet(detents, visibility) = route.style {
                    AnyRoutableView<AnyView>(
                        route: Bindable(route),
                        content: {
                            AnyView(
                                route.NavigatingView()
                                    .presentationDetents(detents)
                                    .presentationDragIndicator(visibility)
                            )
                        }
                    )
                }
            }
        )
        .fullScreenCover(
            item: $route.fullCoverItem,
            onDismiss: $route.fullCoverItem.wrappedValue?.onDismiss,
            content: { route in
                AnyRoutableView<AnyView>(
                    route: Bindable(route),
                    content: {
                        AnyView(route.NavigatingView())
                    }
                )
            }
        )
    }
}
