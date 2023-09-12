//
//  UserDefaultsWorker.swift
//  contrast
//
//  Created by Roman Kiruxin on 28.06.2023.
//

import Foundation

struct UDWConstants {
    struct UserDefaultsKeys {
        static let ACTIVEAPPFIRSTLAUNCH = "ACTIVEAPPFIRSTLAUNCH"
        static let ACTIVEACCESSTOKEN = "ACTIVEACCESSTOKEN"
        static let ACTIVEREFRESHTOKEN = "ACTIVEREFRESHTOKEN"
        static let ACTIVEUSERPHONE = "ACTIVEUSERPHONE"
        static let ACTIVEDEVICETOKEN = "ACTIVEDEVICETOKEN"
        static let BIOMETRYCHANGENEED = "BIOMETRYCHANGENEED"
        static let PINCODEISSET = "PINCODEISSET"
        static let OFFERENTERCODE = "OFFERENTERCODE"
        static let ACTIVESEARCHADDRESS = "ACTIVESEARCHADDRESS"
        static let ORDERPHOTOS = "ORDERPHOTOS"
    }
}

class UserDefaultsWorker {
    // MARK: - Application First Launch
    class func registerActiveAppFirstLaunch(_ value: Bool) {
        UserDefaults.standard.register(defaults: [UDWConstants.UserDefaultsKeys.ACTIVEAPPFIRSTLAUNCH : value])
    }
    
    class func saveActiveAppFirstLaunch(_ value: Bool) {
        UserDefaults.standard.setValue(value, forKey: UDWConstants.UserDefaultsKeys.ACTIVEAPPFIRSTLAUNCH)
    }
    
    class func fetchActiveAppFirstLaunch() -> Bool {
        UserDefaults.standard.bool(forKey: UDWConstants.UserDefaultsKeys.ACTIVEAPPFIRSTLAUNCH)
    }
    
    class func removeActiveAppFirstLaunch() {
        UserDefaults.standard.removeObject(forKey: UDWConstants.UserDefaultsKeys.ACTIVEAPPFIRSTLAUNCH)
    }
    
    // MARK: - AccessToken
    class func saveActiveAccessToken(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: UDWConstants.UserDefaultsKeys.ACTIVEACCESSTOKEN)
    }
    
    class func fetchActiveAccessToken() -> String? {
        UserDefaults.standard.string(forKey: UDWConstants.UserDefaultsKeys.ACTIVEACCESSTOKEN)
    }
    
    class func removeActiveAccessToken() {
        UserDefaults.standard.removeObject(forKey: UDWConstants.UserDefaultsKeys.ACTIVEACCESSTOKEN)
    }
    
    // MARK: - RefreshToken
    class func saveActiveRefreshToken(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: UDWConstants.UserDefaultsKeys.ACTIVEREFRESHTOKEN)
    }
    
    class func fetchActiveRefreshToken() -> String? {
        UserDefaults.standard.string(forKey: UDWConstants.UserDefaultsKeys.ACTIVEREFRESHTOKEN)
    }
    
    class func removeActiveRefreshToken() {
        UserDefaults.standard.removeObject(forKey: UDWConstants.UserDefaultsKeys.ACTIVEREFRESHTOKEN)
    }
    
    // MARK: - User Phone
    class func saveActiveUserPhone(_ phone: String) {
        UserDefaults.standard.setValue(phone, forKey: UDWConstants.UserDefaultsKeys.ACTIVEUSERPHONE)
    }
    
    class func fetchActiveUserPhone() -> String? {
        UserDefaults.standard.string(forKey: UDWConstants.UserDefaultsKeys.ACTIVEUSERPHONE)
    }
    
    class func removeActiveUserPhone() {
        UserDefaults.standard.removeObject(forKey: UDWConstants.UserDefaultsKeys.ACTIVEUSERPHONE)
    }
    
    // MARK: - Active Device Token
    class func saveActiveDevice(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: UDWConstants.UserDefaultsKeys.ACTIVEDEVICETOKEN)
    }
    
    class func fetchActiveDeviceToken() -> String? {
        return UserDefaults.standard.string(forKey: UDWConstants.UserDefaultsKeys.ACTIVEDEVICETOKEN)
    }
    
    class func removeActiveDeviceToken() {
        UserDefaults.standard.removeObject(forKey: UDWConstants.UserDefaultsKeys.ACTIVEDEVICETOKEN)
    }
    
    // MARK: - Biometry change need
    class func saveBiometryChangeNeed(_ value: Bool) {
        UserDefaults.standard.setValue(value, forKey: UDWConstants.UserDefaultsKeys.BIOMETRYCHANGENEED)
    }
    
    class func fetchBiometryChangeNeed() -> Bool? {
        UserDefaults.standard.bool(forKey: UDWConstants.UserDefaultsKeys.BIOMETRYCHANGENEED)
    }
    
    class func removeBiometryChangeNeed() {
        UserDefaults.standard.removeObject(forKey: UDWConstants.UserDefaultsKeys.BIOMETRYCHANGENEED)
    }
    
    // MARK: - Pincode in set
    class func savePincodeIsSet(_ value: Bool) {
        UserDefaults.standard.setValue(value, forKey: UDWConstants.UserDefaultsKeys.PINCODEISSET)
    }
    
    class func fetchPincodeIsSet() -> Bool? {
        UserDefaults.standard.bool(forKey: UDWConstants.UserDefaultsKeys.PINCODEISSET)
    }
    
    class func removePincodeIsSet() {
        UserDefaults.standard.removeObject(forKey: UDWConstants.UserDefaultsKeys.PINCODEISSET)
    }
    
    //MARK: - OfferEnterCode
    class func saveOfferEnterCode(_ value: Bool) {
        UserDefaults.standard.setValue(value, forKey: UDWConstants.UserDefaultsKeys.OFFERENTERCODE)
    }
    
    class func fetchOfferEnterCode() -> Bool? {
        UserDefaults.standard.bool(forKey: UDWConstants.UserDefaultsKeys.OFFERENTERCODE)
    }
    
    class func removeOfferEnterCode() {
        UserDefaults.standard.removeObject(forKey: UDWConstants.UserDefaultsKeys.OFFERENTERCODE)
    }
    
    //MARK: - ActiveSearchAddress
    class func saveActiveSearchAddress(_ address: AddressDataModel) {
        if let encoded = try? JSONEncoder().encode(address) {
            UserDefaults.standard.set(encoded, forKey: UDWConstants.UserDefaultsKeys.ACTIVESEARCHADDRESS)
        }
    }
    
    class func fetchActiveSearchAddress() -> AddressDataModel? {
        if let activeSearchAddressData = UserDefaults.standard.object(forKey: UDWConstants.UserDefaultsKeys.ACTIVESEARCHADDRESS) as? Data {
            let activeSearchAddress = try? JSONDecoder().decode(AddressDataModel.self, from: activeSearchAddressData)
            return activeSearchAddress
        }
        return nil
    }
    
    class func removeActiveSearchAddress() {
        UserDefaults.standard.removeObject(forKey: UDWConstants.UserDefaultsKeys.ACTIVESEARCHADDRESS)
    }

    //MARK: - AddPhotosOrder
    class func saveOrderPhotos(_ PhotosId: [Int]) {
        if let encoded = try? JSONEncoder().encode(PhotosId) {
            UserDefaults.standard.set(encoded, forKey: UDWConstants.UserDefaultsKeys.ORDERPHOTOS)
        }
    }
    
    class func fetchOrderPhotos() -> [Int]? {
        if let orderPhotosData = UserDefaults.standard.object(forKey: UDWConstants.UserDefaultsKeys.ORDERPHOTOS) as? Data,
           let photos = try? JSONDecoder().decode(Array<Int>.self, from: orderPhotosData) {
            return photos
        }
        return nil
    }
    
    class func removeOrderPhotos() {
        UserDefaults.standard.removeObject(forKey: UDWConstants.UserDefaultsKeys.ORDERPHOTOS)
    }
}
