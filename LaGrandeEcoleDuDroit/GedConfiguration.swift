import FirebaseAuth
import FirebaseFirestore

class GedConfiguration {
    private init() {}
    
    #if DEBUG
    static let serverUrl = "http://192.168.1.67:3000"
    static let serverUrl = "https://gedserver.duckdns.org:3000"
    #else
    static let serverUrl = "https://gedserver.duckdns.org:3000"
    #endif
    
    static func configureDebugFirebase() {
        #if DEBUG
        // Firebase Auth
        Auth.auth().useEmulator(withHost:"127.0.0.1", port:9099)

        // Firestore
        let settings = FirestoreSettings()
        settings.host = "127.0.0.1:8080"
        settings.cacheSettings = MemoryCacheSettings()
        settings.isSSLEnabled = false
        Firestore.firestore().settings = settings
        #endif
    }
}
