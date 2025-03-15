# Router
`SwiftUI`에서 `Navigation`과 `Presentation`을 하나로 관리하는 화면 전환 인터페이스입니다.

`Router`는 다음과 같은 목표를 위해 구현되었습니다.
- 복잡한 화면 제어가 가능
- 확장 및 협업에 용이하도록 `PathType Enum`의 분리
- 제한된 방식으로만 `NavigationStack`의 `Path` 접근 가능
- `Push`, `Pop` 외의 다른 화면 이동 로직(`sheet`, `fullScreenCover`)도 한 번에 관리

<br/>

## 발표 링크
[**[Youtube]**](https://www.youtube.com/watch?v=V-i57BnmOFI) 
스유미식회 발표

[**[Notion]**](https://kiwi-river-cf1.notion.site/Router-b1b5aded3e004f28ab48c5c587aebf7f?pvs=4) 관련 내용 정리 노션

## 장점
1. 화면 전환 로직에 사용되는 `Enum`을 분리된 파일에서 관리

- 기능별로 화면을 관리하는 데 용이합니다.
- 협업 시 하나의 Enum에서 path 타입을 관리했을 때, 충돌이 발생하는 문제를 해결합니다.

```swift
// 기존 방식

// PathType.swift
enum PathType {
    case first
    case second

    ... // 동시에 여러 화면 전환 작업 시 충돌

    case twentyth
}

// Router 방식

// FirstRoute.swift
enum FirstRoute: Routable {
    case first
    case second
    ...
}

// SecondRoute.swift
enum SecondRoute: Routable {
    case first
    case second
    ...
}

// ThirdRoute.swift
enum ThirdRoute: Routable {
    case first
    case second
    ...
}
```

<br/>

2. NavigationStack의 Path를 제한된 메서드로만 접근할 수 있습니다.
- 기존 Path 변수를 외부에서 주입해줘야했던 것과 달리, 외부로 Path가 노출되지 않습니다.
- 예상치 못한 방법으로 Path가 수정되는 것을 방지합니다.
```swift
// 기존 방식
NavigationStack(path: $path) { ... } // 외부로 Path 변수가 노출

// Router 방식
Router.shared.Stack { ... } // Router 내부에서 Private 하게 path 변수를 관리합니다.
```

<br/>

## Description
`v1` - `PushRouter` 제공 메서드
```swift
extension Router {
    // 1개 화면 push
    public func push(to routeType: any Routable) { ... }
    
    // N개 화면 push
    public func push(to routeTypes: [any Routable]) { ... }
    
    // 1개 화면 pop
    public func pop() { ... }
    
    // Root 화면으로 pop
    public func popToRoot() { ... }
    
    // Flow의 Root 화면으로 pop
    public func popToRoot(of routeType: RouteType) { ... }
    
    // Flow 전체를 pop
    public func endRoute(of routeType: RouteType) { ... }
}
```

<br/>

`v2` - `Router` 추가 제공 메서드
- 단, `sheet`, `cover`가 `presentation` 된 이후의 `push`는 지원하지 않습니다.
```swift
extension Router {
    public func sheet(
        to routeType: any Routable,
        detents: Set<PresentationDetent>, // sheet 사이즈 조절
        indicatorVisibility: Visibility, // indicator 여부
        onDismiss: (() -> Void)?
    ) { ... }

    public func fullScreenCover(to routeType: any Routable, onDismiss: (() -> Void)?) { ... }
    
    public func dismiss() { ... }
}
```
<br/>


## Getting Started
1. `RouteType Enum`에 `Route` 타입을 추가합니다.
```swift
enum RouteType {
    case root

    // 여기에 RouteType을 추가
    case login
}
```

2. `Routable protocol`을 준수하는 `Enum`을 선언합니다.
```swift
enum LoginRoute: Routable {

    // Login 관련 Route 종류
    case login1
    case login2
    case loginWithData(data: Data) // 주입할 데이터가 있는 경우
    
    // Flow 타입 -> login Flow에 있는 화면들!
    var type: RouteType { .login }
    
    // navigationDestination에 매핑될 뷰
    @ViewBuilder
    internal func NavigatingView() -> some View {
        switch self {
        case .login1:
            LoginView1()
        case .login2:
            LoginView2()
        case loginWithData(let data): // 주입할 데이터가 있는 경우
            LoginWithDataView(data: data)
        }
    }
    
    // Route의 네이밍
    var description: String {
        switch self {
        case .login1:
            "login1"
        case .login2:
            "login2"
        case loginWithData:
            "loginWithData"
        }
    }
}
```

3. `RouterStack`을 최상단에 선언합니다.
```swift
struct ContentView: View {
    var body: some View {
        Router.shared.Stack { // path가 외부에 노출되지 않습니다.
            ...
        }
    }
}
```

4. 화면 전환이 일어나는 곳에서 메서드를 호출합니다.
```swift
struct LoginRootView: View {
    var body: some View {
        Button("Push Login1") {
            Router.shared.push(to: LoginRoute.login1)
        }
        
        Button("Pop All Login") {
            Router.shared.endRoute(of: .login)
        }
        
        Button("Pop to Root") {
            Router.shared.popToRoot()
        }
    }
}
```
