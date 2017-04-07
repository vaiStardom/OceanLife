//
//  FishIdTabBarController.swift
//  OceanLife
//
//  Created by Paul Addy on 3/17/17.
//  Copyright © 2017 Paul Addy. All rights reserved.
//

import UIKit

class FishIdTabBarController: UITabBarController, UITabBarControllerDelegate {

    @IBOutlet weak var fishIdTabBar: UITabBar!
    
    var tabBarSpeciesImage: UIImage!
    var tabBarNotificationsImage: UIImage!
    var tabBarMapImage: UIImage!

}
//MARK: Life-cycle
extension FishIdTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarSpeciesImage = UIImage(named: "TabBarItemNemo")
        tabBarNotificationsImage = UIImage(named: "TabBarItemNotification")
        tabBarMapImage = UIImage(named: "TabBarItemMap")
        
        configureTabBarItems(item: 0)
        
        readDataFromFile(file: "data")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
//MARK: Tab Bar Item Configurations
extension FishIdTabBarController{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        configureTabBarItems(item: item.tag)
    }
    public func configureTabBarItems(item: Int){
        switch item  {
        case FishIdViews.fishId.rawValue:
            
            self.fishIdTabBar.items![FishIdViews.fishId.rawValue].selectedImage = tabBarSpeciesImage.tabBarImageWithCustomTint(tintColor: OceanLifeColor.RedOrange)
            self.fishIdTabBar.items![FishIdViews.notifications.rawValue].image = tabBarNotificationsImage.tabBarImageWithCustomTint(tintColor: OceanLifeColor.RedOrangeOpacity)
            self.fishIdTabBar.items![FishIdViews.map.rawValue].image = tabBarMapImage.tabBarImageWithCustomTint(tintColor: OceanLifeColor.RedOrangeOpacity)
            
        case FishIdViews.notifications.rawValue:
            
            self.fishIdTabBar.items![FishIdViews.fishId.rawValue].image = tabBarSpeciesImage.tabBarImageWithCustomTint(tintColor: OceanLifeColor.RedOrangeOpacity)
            self.fishIdTabBar.items![FishIdViews.notifications.rawValue].selectedImage = tabBarNotificationsImage.tabBarImageWithCustomTint(tintColor: OceanLifeColor.RedOrange)
            self.fishIdTabBar.items![FishIdViews.map.rawValue].image = tabBarMapImage.tabBarImageWithCustomTint(tintColor: OceanLifeColor.RedOrangeOpacity)
            
        case FishIdViews.map.rawValue:
            
            self.fishIdTabBar.items![FishIdViews.fishId.rawValue].image = tabBarSpeciesImage.tabBarImageWithCustomTint(tintColor: OceanLifeColor.RedOrangeOpacity)
            self.fishIdTabBar.items![FishIdViews.notifications.rawValue].image = tabBarNotificationsImage.tabBarImageWithCustomTint(tintColor: OceanLifeColor.RedOrangeOpacity)
            self.fishIdTabBar.items![FishIdViews.map.rawValue].selectedImage = tabBarMapImage.tabBarImageWithCustomTint(tintColor: OceanLifeColor.RedOrange)
            
        default:
            
            self.fishIdTabBar.items![FishIdViews.fishId.rawValue].selectedImage = tabBarSpeciesImage.tabBarImageWithCustomTint(tintColor: OceanLifeColor.RedOrange)
            self.fishIdTabBar.items![FishIdViews.notifications.rawValue].image = tabBarNotificationsImage.tabBarImageWithCustomTint(tintColor: OceanLifeColor.RedOrangeOpacity)
            self.fishIdTabBar.items![FishIdViews.map.rawValue].image = tabBarMapImage.tabBarImageWithCustomTint(tintColor: OceanLifeColor.RedOrangeOpacity)
        }
    }
}
