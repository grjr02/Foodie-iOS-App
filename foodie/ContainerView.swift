//
//  ContainerView.swift
//  foodie
//
//  Created by Gregory Ross on 5/4/19.
//  Copyright © 2019 company. All rights reserved.
//

import UIKit

class ContainerView: UIViewController, VCDelegate {
    
//private var string1: String?
//private var string2: String?


    func passData(string1: String,string2:String ) {

        //nameOfRestaurant?.text = string1
        //addressOfRestaurant?.text = string2
        
        guard let nameOfRestaurant = nameOfRestaurant else { return }
        guard let addressOfRestaurant = addressOfRestaurant else { return }
        
        UIView.transition(with: nameOfRestaurant, duration: 0.25, options: .transitionCurlUp, animations: {
            nameOfRestaurant.text = string1

        }, completion: nil)
        UIView.transition(with: addressOfRestaurant, duration: 0.25, options: .transitionCurlUp, animations: {
            addressOfRestaurant.text = string2
        }, completion: nil)
//        self.string1 = string1
//        self.string2 = string2

    }

    
    @IBOutlet weak var nameOfRestaurant: UILabel!
    
    @IBOutlet weak var urlOfRestaurant: UILabel!
    
    @IBOutlet weak var menuURLOfRestaurant: UILabel!
    
    @IBOutlet weak var addressOfRestaurant: UILabel!
    
    override func viewDidLoad() {
        

        super.viewDidLoad()
        //nameOfRestaurant.text = string1
        
    }
    
}















//    override func viewDidLoad() {
//        super.viewDidLoad()
 
//        rData.getLocation {
//            zone,location  in
//
//            rData.getCuisine {
//                cuisineName,cuisineId  in
//
//                rData.getCount(iD:cuisineId,cuisineZ:zone,locale:location){
//                    start in
//
//                    rData.getRestaurants(iD:cuisineId,cuisineZ:zone,locale:location,startPoint:start){
//                        locationVal,restaurantVal,menuVal,linkVal in
//                        print("\(restaurantVal)\n\(locationVal)\n\(menuVal)\n\(linkVal)")
//
//                        DispatchQueue.main.async {
//                            //Perform segue function with each variable
//                            self.nameOfRestaurant.text = restaurantVal
//                            self.menuURLOfRestaurant.text = menuVal
//                            self.urlOfRestaurant.text = linkVal
//                            self.addressOfRestaurant.text = locationVal
//
//                        }
//
//                    }
//
//                }
//
//            }
//
//
//        }


    
    //}
    

  
//}
