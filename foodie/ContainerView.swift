//
//  ContainerView.swift
//  foodie
//
//  Created by Gregory Ross on 5/4/19.
//  Copyright © 2019 company. All rights reserved.
//
protocol MapProtocol {
    func passMapCoordinates(string: String)
}

import UIKit
import SafariServices

class ContainerView: UIViewController, VCDelegate {

private var link: String?
private var menu: String?
var address: String?

    @IBOutlet weak var titleBar: UINavigationBar!
    
    @IBAction func menuButton(_ sender: Any) {
        showSafari(url: menu!)
    }
    
    @IBAction func linkButton(_ sender: Any) {
        showSafari(url: link!)
    }
    
    @IBOutlet weak var nameOfRestaurant: UILabel!
    
    @IBOutlet weak var urlOfRestaurant: UILabel!
    
    @IBOutlet weak var menuURLOfRestaurant: UILabel!
    
    @IBOutlet weak var addressOfRestaurant: UILabel!
    
    //Protocol
    func passData(restaurantName: String,address:String,link:String,menu:String) {
        
        self.address = address
        self.link = link
        self.menu = menu
        
        guard let nameOfRestaurant = nameOfRestaurant else { return }
        
        UIView.transition(with: nameOfRestaurant, duration: 0.25, options: .curveLinear, animations: {
            nameOfRestaurant.text = restaurantName
        }, completion: nil)
        
        guard let addressOfRestaurant = addressOfRestaurant else { return }
        
        UIView.transition(with: addressOfRestaurant, duration: 0.25, options: .curveLinear, animations: {
            addressOfRestaurant.text = address
        }, completion: nil)
        
        for child in self.children {
            if let child = child as? MapViewViewController {
                child.passMapCoordinates(string: address)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MapViewViewController {
            //guard let addressNew = address else {return}
            //destination.passMapCoordinates(address: address!)
        }
    }
    
}

extension ContainerView{
    
    func showSafari(url: String){
        guard let safariURL = URL(string: url) else { return }
        
        let safariVC = SFSafariViewController(url: safariURL)
        present(safariVC,animated: true)
    }
    
}










