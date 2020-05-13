import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        window?.windowScene = windowScene
        
        if UserDefaults.standard.object(forKey: "Token") != nil {
            let vc = storyboard.instantiateViewController(withIdentifier: "tabBarController")
            window?.rootViewController = vc
        } else {
            let vc = storyboard.instantiateViewController(withIdentifier: "loginVC")
            window?.rootViewController = vc
        }
        let vc = storyboard.instantiateViewController(withIdentifier: "tabBarController")
        window?.rootViewController = vc
       
        window?.backgroundColor = UIColor.clear
        window?.makeKeyAndVisible()
        
        appDelegate.window = self.window
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

