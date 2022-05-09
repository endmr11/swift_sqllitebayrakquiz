//
//  SonucEkraniViewController.swift
//  udemy_sqlbayrakquiz
//
//  Created by Eren Demir on 9.05.2022.
//

import UIKit

class SonucEkraniViewController: UIViewController {

    
    @IBOutlet weak var labelSonuc: UILabel!
    @IBOutlet weak var labelBasari: UILabel!
    var dogruSayisi:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        if let d = dogruSayisi {
            labelSonuc.text = "\(d) DOĞRU \(5-d) YANLIŞ"
            labelBasari.text = "% \(d*100/5) BAŞARI"
        }
    }

    @IBAction func tekrarDene(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
