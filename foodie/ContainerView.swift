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

private var string3: String?
private var string4: String?
var string2: String?

    @IBOutlet weak var titleBar: UINavigationBar!
    
    @IBAction func menuButton(_ sender: Any) {
        showSafari(url: string4!)
    }
    
    @IBAction func linkButton(_ sender: Any) {
        showSafari(url: string3!)
    }
    
    func passData(string1: String,string2:String,string3:String,string4:String) {
        
        self.string2 = string2
        self.string3 = string3
        self.string4 = string4

        guard let nameOfRestaurant = nameOfRestaurant else { return }
        guard let addressOfRestaurant = addressOfRestaurant else { return }
        
        UIView.transition(with: nameOfRestaurant, duration: 0.25, options: .curveLinear, animations: {
            nameOfRestaurant.text = string1

        }, completion: nil)
        UIView.transition(with: addressOfRestaurant, duration: 0.25, options: .curveLinear, animations: {
            addressOfRestaurant.text = string2
        }, completion: nil)
        
        //print(string2)
        
        for child in self.children {
            if let child = child as? MapViewViewController {
                child.passMapCoordinates(string: string2)
            }
        }

    }
    
    @IBOutlet weak var nameOfRestaurant: UILabel!
    
    @IBOutlet weak var urlOfRestaurant: UILabel!
    
    @IBOutlet weak var menuURLOfRestaurant: UILabel!
    
    @IBOutlet weak var addressOfRestaurant: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DispatchQueue.main.async {
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MapViewViewController {
            //guard let newString2 = string2 else {return}
            //destination.passMapCoordinates(string: string2!)
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










