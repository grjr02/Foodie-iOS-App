struct CuisineType:Decodable{
    let cuisines: [Cuisine]
}
struct Cuisine:Decodable{
    let cuisine: CuisineName?
}
struct CuisineName:Decodable{
    let cuisine_id:Int
    let cuisine_name:String
}
struct Restaurants:Decodable{
    let results_found: Int
    let restaurants:[Restaurant]
}
struct Restaurant:Decodable{
    let restaurant:RestaurantInfo?
}
struct RestaurantInfo:Decodable{
    let name:String?
    let url:String?
    let menu_url:String?
    let location:RestaurantLocal
}
struct RestaurantLocal:Decodable{
    let address:String?
}
struct GeoLocation:Decodable{
    let location:GeoInfo
}
struct GeoInfo:Decodable{
    let entity_id:Int
    let entity_type:String?
}

import UIKit
import CoreLocation


class rData: NSObject {
    
    class func getLocation(latitude:String, longitude:String,completionHandler: @escaping (_ zone: String,_ location: Int) -> ()) {

        let urlName = "https://developers.zomato.com/api/v2.1/geocode?lat=\(latitude)&lon=\(longitude)"
        let zomatoKey = "1879a59717412359f030b0bb600a390a"

        let url = URL(string: urlName)
        var urlReq = URLRequest(url: url!)
        urlReq.httpMethod = "GET"
        urlReq.addValue("application/json", forHTTPHeaderField: "Accept")
        urlReq.addValue(zomatoKey, forHTTPHeaderField: "user_key")
        
        let task = URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                let items3 = try JSONDecoder().decode(GeoLocation.self, from: data)
                
                let location = items3.location.entity_id
                let zone = items3.location.entity_type!
                
                DispatchQueue.main.async {
                }
                
                //print("Location: " + "\(location)")
                //print("Zone: " + zone)
                completionHandler(zone,location)
            }
                
            catch {
                print(error)
                
            }
        }
        
        task.resume()
        
    }
    class func getCuisine(completionHandler: @escaping (_ cuisineName: String,_ cuisineId: Int) -> ()) {
        
        let urlName = "https://developers.zomato.com/api/v2.1/cuisines?city_id=280"
        let zomatoKey = "1879a59717412359f030b0bb600a390a"
        
        let url = URL(string: urlName)
        var urlReq = URLRequest(url: url!)
        urlReq.httpMethod = "GET"
        urlReq.addValue("application/json", forHTTPHeaderField: "Accept")
        urlReq.addValue(zomatoKey, forHTTPHeaderField: "user_key")
        
        let task = URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            guard let data = data else {return}
            
            do {
                let items = try JSONDecoder().decode(CuisineType.self, from: data)
                
                //****Putting json data into a string***********
                
                var arrayOfNames: [String] = []
                var arrayOfIds: [Int] = []
                
                let zoms = items.cuisines
                for item in zoms {
                    let possibleName = item.cuisine?.cuisine_name
                    if let name = possibleName {
                        arrayOfNames.append(name)
                    }
                    let possibleID = item.cuisine?.cuisine_id
                    if let iD = possibleID {
                        arrayOfIds.append(iD)
                    }
                }
                let randomInt = Int.random(in: 0..<arrayOfIds.count)
                
                let cuisineName = arrayOfNames//.randomElement()!
                //print(cuisineName[randomInt])
                let cuisineId = arrayOfIds//.randomElement()!
                //print(cuisineId[randomInt])
                
                //self.getRestaurants(iD:cuisineId[randomInt])
                completionHandler(cuisineName[randomInt],cuisineId[randomInt])
            }
                
            catch {
                print(error)
            }
            
        }
        
        task.resume()
        
    }
    class func getCount(iD:Int,cuisineZ:String,locale:Int,completionHandler: @escaping (_ start: Int) -> ()){
        let urlName2 = "https://developers.zomato.com/api/v2.1/search?entity_id=\(locale)&entity_type=\(cuisineZ)"
        let zomatoKey = "1879a59717412359f030b0bb600a390a"
        
        let url2 = URL(string: urlName2)!
        var urlReq2 = URLRequest(url: url2)
        urlReq2.httpMethod = "GET"
        urlReq2.addValue("application/json", forHTTPHeaderField: "Accept")
        urlReq2.addValue(zomatoKey, forHTTPHeaderField: "user_key")
        
        let task2 = URLSession.shared.dataTask(with: urlReq2) { (data, response, error) in
            
            guard let data = data else {return}
            
            do{
                let items2 = try JSONDecoder().decode(Restaurants.self, from: data)
                
                let resultCount = items2.results_found
                var start = 0
                
                if(resultCount <= 20){
                    start = 0;
                    completionHandler(start)
                }else if(resultCount >= 20){
                    start = Int.random(in: 0...80)
                    completionHandler(start)
                }
                
            }catch{
                print(error)
            }
            
        }
        
        task2.resume()
    }
    
    class func getRestaurants(iD:Int,cuisineZ:String,locale:Int,startPoint:Int,completionHandler: @escaping (_ locationVal: String,_ restaurantVal: String,_ menuVal: String,_ linkVal: String) -> ()){
        let urlName2 = "https://developers.zomato.com/api/v2.1/search?entity_id=\(locale)&entity_type=\(cuisineZ)&start=\(startPoint)&count=20&sort=rating"
        let zomatoKey = "1879a59717412359f030b0bb600a390a"
        
        let url2 = URL(string: urlName2)!
        var urlReq2 = URLRequest(url: url2)
        urlReq2.httpMethod = "GET"
        urlReq2.addValue("application/json", forHTTPHeaderField: "Accept")
        urlReq2.addValue(zomatoKey, forHTTPHeaderField: "user_key")
        
        let task2 = URLSession.shared.dataTask(with: urlReq2) { (data, response, error) in
            
            guard let data = data else {return}
            
            do{
                let items2 = try JSONDecoder().decode(Restaurants.self, from: data)
                var arrayOfRestaurants:[String] = []
                var arrayOfMenus:[String] = []
                var arrayOfLinks:[String] = []
                var arrayOfLocations:[String]=[]
                //let resultCount = items2.results_found
                for restaurants in items2.restaurants{
                    let possibleRestaurant = restaurants.restaurant?.name
                    if let name = possibleRestaurant {
                        arrayOfRestaurants.append(name)
                    }
                    let possibleMenu = restaurants.restaurant?.menu_url
                    if let menu = possibleMenu {
                        arrayOfMenus.append(menu)
                    }
                    let possibleUrl = restaurants.restaurant?.url
                    if let urlLink = possibleUrl {
                        arrayOfLinks.append(urlLink)
                    }
                    let possibleLoc = restaurants.restaurant?.location.address
                    if let address = possibleLoc {
                        arrayOfLocations.append(address)
                    }
                }
          
                let randomInt = Int.random(in: 0..<arrayOfRestaurants.count)
        
                let locationVal = arrayOfLocations[randomInt]
                let restaurantVal = arrayOfRestaurants[randomInt]
                let menuVal = arrayOfMenus[randomInt]
                //guard let menuURL = URL(string: menuVal) else {return}
                let linkVal = arrayOfLinks[randomInt]
                //guard let linkURL = URL(string: linkVal) else{return}
                
                completionHandler(locationVal,restaurantVal,menuVal,linkVal)
   
                
            }catch{
                print(error)
            }
        }
        
        task2.resume()
    }

}

