import UIKit
    
class ViewController: UIViewController {
    
    @IBOutlet weak var nameOfRestaurant: UILabel!
    
    @IBOutlet weak var urlOfRestaurant: UILabel!
    
    @IBOutlet weak var menuURLOfRestaurant: UILabel!
    
    @IBOutlet weak var addressOfRestaurant: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        rData.getLocation {
            zone,location  in
            
            rData.getCuisine {
                cuisineName,cuisineId  in

                rData.getCount(iD:cuisineId,cuisineZ:zone,locale:location){
                    start in

                    rData.getRestaurants(iD:cuisineId,cuisineZ:zone,locale:location,startPoint:start){
                        locationVal,restaurantVal,menuVal,linkVal in
                        print("\(restaurantVal)\n\(locationVal)\n\(menuVal)\n\(linkVal)")
                        
                        DispatchQueue.main.async {
                            
                            self.nameOfRestaurant.text = restaurantVal
                            self.menuURLOfRestaurant.text = menuVal
                            self.urlOfRestaurant.text = linkVal
                            self.addressOfRestaurant.text = locationVal
        
                        }
                        
                    }

                }

            }
            
        }

    }

}
