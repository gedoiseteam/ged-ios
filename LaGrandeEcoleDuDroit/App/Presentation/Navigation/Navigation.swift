import Combine
import SwiftUI
import Foundation

struct Navigation: View {
    @StateObject private var viewModel: NavigationViewModel = MainInjection.shared.resolve(NavigationViewModel.self)
   
    var body: some View {
        ZStack {
            switch viewModel.uiState.startDestination {
                case .authentication: AuthenticationNavigation()
                case .home: MainNavigation()
                        .environmentObject(viewModel)
                case .splash: SplashScreen()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

struct MainNavigation: View {
    @EnvironmentObject var viewModel: NavigationViewModel
    @State var selectedTab: TopLevelDestination = .home
    @StateObject private var tabBarVisibility = TabBarVisibility()

    var body: some View {
        TabView(selection: $selectedTab) {
            ForEach(TopLevelDestination.allCases, id: \.self) { destination in
                tabView(for: destination)
            }
        }
    }

    @ViewBuilder
    private func tabView(for destination: TopLevelDestination) -> some View {
        let icon = selectedTab == destination ? destination.filledIcon : destination.outlinedIcon
        let badgeCount = viewModel.uiState.badges[destination] ?? 0

        destinationView(for: destination)
            .environmentObject(tabBarVisibility)
            .tabItem {
                Label(destination.label, systemImage: icon)
                    .environment(\.symbolVariants, .none)
            }
            .badge(badgeCount)
            .tag(destination)
            .toolbar(tabBarVisibility.show ? .visible : .hidden, for: .tabBar)
    }

    @ViewBuilder
    private func destinationView(for destination: TopLevelDestination) -> some View {
        switch destination {
        case .home:
            NewsNavigation()
        case .message:
            MessageNavigation()
        case .profile:
            ProfileNavigation()
        }
    }
}

class TabBarVisibility: ObservableObject {
    @Published var show: Bool = false
}

#Preview {
    MainNavigation()
        .environmentObject(
            MainInjection.shared.resolveWithMock().resolve(NavigationViewModel.self)!
        )
}
