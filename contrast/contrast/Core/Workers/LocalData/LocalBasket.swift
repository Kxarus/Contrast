//
//  LocalBasket.swift
//  contrast
//
//  Created by Roman Kiruxin on 14.07.2023.
//

import Foundation

final class LocalBasket {
    
    private var newSum: Double?
    private static var _shared: LocalBasket?
    
    private var basketItems: [BasketItemLocal] {
        didSet {
            NotificationCenter.default
                        .post(name:           NSNotification.Name("ub.basketUpdate"),
                         object: nil,
                         userInfo: nil)
        }
    }
    
    private init() {
        basketItems = []
    }
    
    public static var shared: LocalBasket {
        get {
            if _shared == nil {
                DispatchQueue.global().sync(flags: .barrier) {
                    if _shared == nil {
                        _shared = LocalBasket()
                    }
                }
            }
            return _shared!
        }
    }
}

//MARK: - Public methods
extension LocalBasket {
    func getItemsFromBasket() -> [BasketItemLocal] {
        return basketItems
    }
    
    func getItemsWithWithoutExpress() -> Bool {
        for item in basketItems {
            if item.productCount != 0 {
                if !item.productVariant!.isExpressAvailable {
                    print("47477474744774")
                    print(!item.productVariant!.isExpressAvailable)
                    return true
                }
            }
        }
        return false
    }
    
    func addToBasket(productVariant: CatalogItemModel) {
        for basketItem in basketItems {
            if basketItem.productVariant!.id == productVariant.id {
                basketItem.productCount = basketItem.productCount + 1
                return
            }
        }
        var basketItem: BasketItemLocal = BasketItemLocal()
        basketItem.productVariant = productVariant
        basketItem.productCount = 1
        self.newSum = nil
        basketItems.append(basketItem)
    }
    
    func addToBasket(productVariantId: Int, additionalServiceId: Int) {
        for basketItem in basketItems {
            if basketItem.productVariant!.id == productVariantId {
                for index in 0..<basketItem.productVariant!.additionalServices.count {
                    if basketItem.productVariant!.additionalServices[index].id == additionalServiceId {
                        basketItem.productVariant!.additionalServices[index].count = 1
                    }
                }
            }
        }
        self.newSum = nil
    }
    
    func removeFromBasket(productVariantId: Int, additionalServiceId: Int) {
        for basketItem in basketItems {
            if basketItem.productVariant!.id == productVariantId {
                for index in 0..<basketItem.productVariant!.additionalServices.count {
                    if basketItem.productVariant!.additionalServices[index].id == additionalServiceId {
                        basketItem.productVariant!.additionalServices[index].count = 0
                    }
                }
            }
        }
        self.newSum = nil
    }
    
    func clearBasket(){
        self.newSum = nil
        self.basketItems.removeAll()
    }
    
    func removeFromBasket(productVariant: CatalogItemModel) {
        var indexToDelete: Int = -1
        var index = 0
        for basketItem in basketItems {
            if basketItem.productVariant!.id == productVariant.id {
                basketItem.productCount = basketItem.productCount - 1
                
                if basketItem.productCount == 0 {
                    for index in 0..<basketItem.productVariant!.additionalServices.count {
                        basketItem.productVariant!.additionalServices[index].count = 0
                    }
                    
                    indexToDelete = index
                    basketItems.remove(at: index)
                }
            }
            index = index + 1
        }
        self.newSum = nil
    }
    
    func calcBasket() -> Float {
        var result: Float = 0
        for item in basketItems {
            result = result + (item.productVariant!.price * Float(item.productCount))
            
            for addServ in item.productVariant!.additionalServices {
                if addServ.count == 1 {
                    result = result + (addServ.price)
                }
            }
        }
        return result
    }
}

class BasketItemLocal {
    var productVariant: CatalogItemModel?
    var productCount: Int = 0 {
        didSet {
            NotificationCenter.default
                        .post(name:           NSNotification.Name("ub.basketUpdate"),
                         object: nil,
                         userInfo: nil)
            
        }
    }
}
