import UIKit


protocol VCDelegate {
    
    //func passData(theData1:String,theData2:String,theData3:String,theData4:String)
    func passData(string1:String,string2:String)

}


    class ViewController: UIViewController {

    var delegate : VCDelegate?
    
    @IBAction func getRestaurantInformation(_ sender: Any) {
        

        rData.getLocation {
            zone,location  in
        
            rData.getCuisine {
                cuisineName,cuisineId  in
        
                rData.getCount(iD:cuisineId,cuisineZ:zone,locale:location){
                    start in
        
                    rData.getRestaurants(iD:cuisineId,cuisineZ:zone,locale:location,startPoint:start){
                        locationVal,restaurantVal,menuVal,linkVal in
                        //print("\(restaurantVal)\n\(locationVal)\n\(menuVal)\n\(linkVal)")
        
                        DispatchQueue.main.async {
        
                            for child in self.children {
                                if let child = child as? ContainerView {
                                    child.passData(string1: restaurantVal,string2:locationVal)
                                }
                            }
        
                            
                        }
                    }
        
                }
        
            }
        
        }

        
        
        
        
    }
        
        override func viewDidLoad() {
            
            
            super.viewDidLoad()
            
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            if let destination = segue.destination as? ContainerView {
                destination.passData(string1: "",string2: "")
            }
            
        }
    
}













    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if(segue.identifier == "segue"){
//            self.delegate = segue.destination as! ContainerView
//        }
//    }

//    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        if(segue.identifier == "segue"){
//            self.delegate = segue.destination as! ContainerView
//        }
//    }
    
    
    
        
        
    
    

        
//    }


