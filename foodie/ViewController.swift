import UIKit
import CoreLocation


protocol VCDelegate {
    func passData(restaurantName:String,address:String,link:String,menu:String)
}

var viewController = ViewController()

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    
    @IBOutlet weak var button: UIButton!
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var container: UIView!
    
    var delegate : VCDelegate?
    let locationManager = CLLocationManager()
    var longitude = ""
    var latitude = ""
        
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController = self
        viewController.container.isHidden = true
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        button.center = self.view.center
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let locationValue : CLLocationCoordinate2D = manager.location?.coordinate else{return}
        
        latitude = String(locationValue.latitude)
        longitude = String(locationValue.longitude)
        print(latitude + " " + longitude)
    }
    
    
    @IBAction func getRestaurantInformation(button: UIButton) {
   
        load()
        
        rData.getLocation (latitude: self.latitude, longitude: self.longitude){
            zone,location  in
        
            rData.getCuisine {
                cuisineName,cuisineId  in
        
                rData.getCount(iD:cuisineId,cuisineZ:zone,locale:location){
                    start in
                    
                    rData.getRestaurants(iD:cuisineId,cuisineZ:zone,locale:location,startPoint:start){
                            locationVal,restaurantVal,menuVal,linkVal in
                            print("\(restaurantVal)\n\(locationVal)\n\(menuVal)\n\(linkVal)")
        
                        DispatchQueue.main.async {
        
                            for child in self.children {
                                if let child = child as? ContainerView {
                                    child.passData(restaurantName: restaurantVal,address:locationVal,link:linkVal,menu:menuVal)
                                }
                            }
                            
                            self.moveButton(button: button)
                            
                            UIView.transition(with: self.container, duration: 1.0, options: .transitionCrossDissolve, animations: {}, completion: nil)
                            
                            viewController.container.isHidden = false
                            
                            self.stop()
                            
                        }
                    }
        
                }
        
            }
        
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ContainerView {
        //destination.passData(restaurantName: "",address: "",link: "",menu: "")
        }
    }
    
}

extension ViewController{

    func load() {
        activityIndicator.center = container.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func stop(){
        self.activityIndicator.stopAnimating()
    }
    
    func moveButton(button: UIButton ){
        let buttonHeight = button.frame.height
        let viewHeight = button.superview!.bounds.height
        UIView.transition(with: button, duration: 1.0, options: .curveLinear, animations: {}, completion: nil)
        button.center.y = viewHeight/4 + buttonHeight * 3
    }
    
}















