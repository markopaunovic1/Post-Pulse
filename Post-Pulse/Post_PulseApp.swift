
import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct Post_PulseApp: App {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var createAdViewModel = CreateAdViewModel(authViewModel: AuthViewModel())
    @StateObject var favoriteItemViewModel = FavoriteViewModel()
    @StateObject var userOwnAdsViewModel = UserOwnAdViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ItemViewModel())
                .environmentObject(authViewModel)
                .environmentObject(createAdViewModel)
                .environmentObject(favoriteItemViewModel)
                .environmentObject(userOwnAdsViewModel)
        }
    }
}
