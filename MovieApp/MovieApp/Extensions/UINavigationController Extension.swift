import UIKit

extension UINavigationController {
    func configureTabBarItem(_ title: String, image: String) {
        self.tabBarItem.title = title
        self.tabBarItem.image = UIImage(systemName: image)

//        self.tabBarItem.selectedImage = UIImage(named: selectedImage)

        //перенести в другое место для разделения ответственности?
        self.view.backgroundColor = .customBlack
    }
}
