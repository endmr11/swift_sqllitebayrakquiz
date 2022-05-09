//
//  Bayrakdao.swift
//  udemy_sqlbayrakquiz
//
//  Created by Eren Demir on 9.05.2022.
//

import Foundation

class BayrakDao {
    let db:FMDatabase?
    init(){
        let hedefYol =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("bayrakquiz.db")
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func rastgele5Getir() -> [Bayraklar] {
        var liste = [Bayraklar]()
        db?.open()
        do {
            let rs = try db!.executeQuery("SELECT * FROM bayraklar ORDER BY RANDOM() LIMIT 5", values: nil)
            while rs.next() {
                let bayrak = Bayraklar(
                    bayrak_id: Int(rs.string(forColumn: "bayrak_id"))!,
                    bayrak_ad: rs.string(forColumn: "bayrak_ad")!,
                    bayrak_resim: rs.string(forColumn: "bayrak_resim")!)
                liste.append(bayrak)
            }
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
    
    func rastgele3SecenekGetir(bayrak_id:Int) -> [Bayraklar] {
        var liste = [Bayraklar]()
        db?.open()
        do {
            let rs = try db!.executeQuery("SELECT * FROM bayraklar WHERE bayrak_id != ? ORDER BY RANDOM() LIMIT 5", values: [bayrak_id])
            while rs.next() {
                let bayrak = Bayraklar(
                    bayrak_id: Int(rs.string(forColumn: "bayrak_id"))!,
                    bayrak_ad: rs.string(forColumn: "bayrak_ad")!,
                    bayrak_resim: rs.string(forColumn: "bayrak_resim")!)
                liste.append(bayrak)
            }
        } catch {
            print(error.localizedDescription)
        }
        db?.close()
        return liste
    }
}
