//
//  ShoppingCart.swift
//  Lojinha
//
//  Created by Bruno Corrêa on 19/06/2018.
//

import Foundation
import Firebase

private let caTaxPercentage = 0.08
private let freeShippingLimit = 50.00
private let defaultShippingFee = 5.99

class ShoppingCart{
    
    var products: [Product]?
    var shipping: Double?
    var subtotal: Double?
    var tax: Double?
    var total: Double?
    
    func fetch(_ completion: @escaping() -> Void)
    {
        let userUID = Auth.auth().currentUser!.uid
        let ref = DatabaseRef.user(uid: userUID).ref().child("shoppingCart")
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
            
            if let cart = currentData.value as? [String : Any],
                let shipping = cart["shipping"] as? Double,
                let subtotal = cart["subtotal"] as? Double,
                let tax = cart["tax"] as? Double,
                let total = cart["total"] as? Double,
                let productsDictionary = cart["products"] as? [String : Any] {
                self.shipping = shipping
                self.subtotal = subtotal
                self.total = total
                self.tax = tax
                
                self.products = [Product]()
                for (_, productDict) in productsDictionary {
                    if let productDict = productDict as? [String : Any] {
                        let product = Product(dictionary: productDict)
                        self.products?.append(product)
                    }
                }
                
                completion()
            }
            
            return TransactionResult.success(withValue: currentData)
            
        }) { (error, committed, snapshot) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    class func add(product: Product){
        
        let userUID = Auth.auth().currentUser!.uid
        let ref = DatabaseRef.user(uid: userUID).ref().child("shoppingCart")
        ref.runTransactionBlock({ (currentData: MutableData) -> TransactionResult in
          
            var cart = currentData.value as? [String : Any] ?? [:]
            var productDictionary = cart["products"] as? [String : Any] ?? [:]
            
            productDictionary[product.uid!] = product.toDictionary()
            
            var subtotal: Double = 0
            var shipping: Double = 0
            var tax: Double = 0
            var total: Double = 0
            
            for(_, prodDict) in productDictionary{
                if let prodDict = prodDict as? [String : Any]{
                    let price = prodDict["price"] as! Double
                    subtotal += price
                }
            }
            
            if subtotal >= freeShippingLimit || subtotal == 0{
                shipping = 0
            }else{
                shipping = defaultShippingFee
            }
            
            tax = (subtotal + shipping) * caTaxPercentage
            total = subtotal + shipping + tax
            
            cart["subtotal"] = subtotal
            cart["shipping"] = shipping
            cart["tax"] = tax
            cart["total"] = total
            cart["products"] = productDictionary
            
            currentData.value = cart
            
            return TransactionResult.success(withValue: currentData)
            
        }) { (error, committed, snapshot) in
            if let error = error{
                print(error.localizedDescription)
            }
        }
    }
}
