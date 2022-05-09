//
//  ViewController.swift
//  udemy_sqlbayrakquiz
//
//  Created by Eren Demir on 9.05.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        veritabaniKopyala()
    }

    func veritabaniKopyala() {
        let bundleYol = Bundle.main.path(forResource: "bayrakquiz", ofType: ".db")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let fileManager = FileManager.default
        let kopyalanacakYol = URL(fileURLWithPath: hedefYol).appendingPathComponent("bayrakquiz.db")
        if fileManager.fileExists(atPath: kopyalanacakYol.path){
            print("Veritabanı zaten var.")
        }else{
            do {
                try fileManager.copyItem(at: URL(fileURLWithPath: bundleYol!), to: URL(fileURLWithPath: kopyalanacakYol.path))
            }catch{
                print(error)
            }
        }
    }
}

