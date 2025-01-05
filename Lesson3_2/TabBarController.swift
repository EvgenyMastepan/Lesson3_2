//
//  ViewController.swift
//  Lesson3_2
//
//  Created by Evgeny Mastepan on 04.01.2025.
//

import UIKit

class TabBarView: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setTab()
    }

    private func setTab(){
        tabBar.backgroundColor = .white
        tabBar.tintColor = .orange
        tabBar.unselectedItemTintColor = .systemGray
        
        let textVC = settingTab(controllerName: TextTabController(), imageName: "text.bubble", selectedImageName: "text.bubble.fill", titleString: "Текст")
        let imageVC = settingTab(controllerName: ImageTabController(), imageName: "rectangle.3.group.bubble.left", selectedImageName: "rectangle.3.group.bubble.left.fill", titleString: "Изображение")
        let settingVC = settingTab(controllerName: SettingsTabController(), imageName: "wrench.and.screwdriver", selectedImageName: "wrench.and.screwdriver.fill", titleString: "Настройка")
        
        setViewControllers([textVC, imageVC, settingVC], animated: true)
    }

    private func settingTab(controllerName: UIViewController, imageName: String, selectedImageName: String, titleString: String) -> UIViewController {
        let vc = controllerName
        vc.tabBarItem.image = UIImage(systemName: imageName)
        vc.tabBarItem.selectedImage = UIImage(systemName: selectedImageName)
        vc.tabBarItem.title = titleString
        return vc
    }

}

