//
//  QuizEkraniViewController.swift
//  udemy_sqlbayrakquiz
//
//  Created by Eren Demir on 9.05.2022.
//

import UIKit

class QuizEkraniViewController: UIViewController {

    @IBOutlet weak var labelDogru: UILabel!
    @IBOutlet weak var labelYanlis: UILabel!
    @IBOutlet weak var labelSoruSayisi: UILabel!
    @IBOutlet weak var bayrakImageView: UIImageView!
    @IBOutlet weak var buttonAText: UIButton!
    @IBOutlet weak var buttonBText: UIButton!
    @IBOutlet weak var buttonCText: UIButton!
    @IBOutlet weak var buttonDText: UIButton!
    
    var sorular = [Bayraklar]()
    var yanlisSecenekler = [Bayraklar]()
    
    var dogruSoru = Bayraklar()
    
    var soruSayac = 0
    var dogruSayac = 0
    var yanlisSayac = 0
    
    var secenekler = [Bayraklar]()
    var seceneklerKaristirmaListesi = Set<Bayraklar>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sorular = BayrakDao().rastgele5Getir()
        soruYukle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gidilecekVC = segue.destination as! SonucEkraniViewController?
        gidilecekVC?.dogruSayisi = dogruSayac
    }
    
    func soruYukle() {
        labelSoruSayisi.text = "\(soruSayac+1)"
        labelDogru.text = "Doğru: \(dogruSayac)"
        labelYanlis.text = "Yanlış: \(yanlisSayac)"
        
        dogruSoru = sorular[soruSayac]
        bayrakImageView.image = UIImage(named: dogruSoru.bayrak_resim!)
        
        yanlisSecenekler = BayrakDao().rastgele3SecenekGetir(bayrak_id: dogruSoru.bayrak_id!)
        
        seceneklerKaristirmaListesi.removeAll()
        seceneklerKaristirmaListesi.insert(dogruSoru)
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[0])
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[1])
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[2])
        secenekler.removeAll()
        for b in seceneklerKaristirmaListesi {
            secenekler.append(b)
        }
        buttonAText.setTitle(secenekler[0].bayrak_ad, for: .normal)
        buttonBText.setTitle(secenekler[1].bayrak_ad, for: .normal)
        buttonCText.setTitle(secenekler[2].bayrak_ad, for: .normal)
        buttonDText.setTitle(secenekler[3].bayrak_ad, for: .normal)
    }
    
    
    func dogruKontrol(button:UIButton){
        let buttonYazi = button.titleLabel?.text
        let dogruCevap = dogruSoru.bayrak_ad
        if buttonYazi == dogruCevap {
            dogruSayac += 1
        }else{
            yanlisSayac += 1
        }
        labelDogru.text = "Doğru: \(dogruSayac)"
        labelYanlis.text = "Yanlış: \(yanlisSayac)"
    }
    
    func soruSayacKontrol(){
        soruSayac += 1
        if soruSayac != 5 {
            soruYukle()
        }else{
            performSegue(withIdentifier: "quizEkraniToSonucEkrani", sender:nil)
        }
    }
    
    @IBAction func buttonA(_ sender: Any) {
        dogruKontrol(button: buttonAText)
        soruSayacKontrol()
    }
    
    @IBAction func buttonB(_ sender: Any) {
        dogruKontrol(button: buttonBText)
        soruSayacKontrol()
    }
    @IBAction func buttonC(_ sender: Any) {
        dogruKontrol(button: buttonCText)
        soruSayacKontrol()
    }
    @IBAction func buttonD(_ sender: Any) {
        dogruKontrol(button: buttonDText)
        soruSayacKontrol()
    }
}
