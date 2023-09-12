//
//  Services.swift
//  contrast
//
//  Created by Roman Kiruxin on 28.06.2023.
//

import Alamofire
import Foundation
import Moya
import UIKit

final class Services {
    private let service: NetworkServiceable
    
    init(service: NetworkServiceable) {
        self.service = service
    }
}

// MARK: - Public methods

extension Services {
    //MARK: - UserAuth
    func performUserAuth(_ request: UserAuthRequest, complition: @escaping (Result<UserAuthResponse, ApiErrorModel>) -> Void) {
        service.request(.userAuth(request: request), completion: complition)
    }
    
    //MARK: - UserVerify
    func performUserVerify(_ request: UserVerifyRequest, complition: @escaping (Result<UserVerifyResponse, ApiErrorModel>) -> Void) {
        service.request(.userVerify(request: request), completion: complition)
    }
    
    //MARK: - ClientInvited
    func performClientInvited(_ request: ClientInvitedRequest, complition: @escaping (Result<String, ApiErrorModel>) -> Void) {
        service.requestVoid(.clientInvited(request: request), completion: complition)
    }
    
    //MARK: - UserRefresh
    func performUserRefresh(complition: @escaping (Result<UserVerifyResponse, ApiErrorModel>) -> Void) {
        service.request(.userRefresh, completion: complition)
    }
    
    //MARK: - PERFORM STORIES
    func performStories(complition: @escaping (Result<[StoriesResponse], ApiErrorModel>) -> Void) {
        service.request(.stories, completion: complition)
    }
    
    //MARK: - Catalog
    func performCatalog(complition: @escaping (Result<[CatalogResponse], ApiErrorModel>) -> Void) {
        service.request(.fetchCatalog, completion: complition)
    }
    
    //MARK: - Favourites
    func performFavourites(complition: @escaping (Result<[Int], ApiErrorModel>) -> Void) {
        service.request(.getFavourites, completion: complition)
    }
    
    func performAddFavourites(_ request: FavouritesRequest,complition: @escaping (Result<String, ApiErrorModel>) -> Void) {
        service.requestVoid(.addFavourites(request: request), completion: complition)
    }
    
    func performRemoveFavourites(_ request: FavouritesRequest,complition: @escaping (Result<String, ApiErrorModel>) -> Void) {
        service.requestVoid(.removeFavourites(request: request), completion: complition)
    }
    
    //MARK: - Map
    func performZonesGeolocate(_ request: CoordinateRequest, complition: @escaping (Result<[ZonesGeolocateResponse], ApiErrorModel>) -> Void) {
        service.request(.zonesGeolocate(request: request), completion: complition)
    }
    
    func performZonesCheck(_ request: CoordinateRequest, complition: @escaping (Result<ZonesCheckResponse, ApiErrorModel>) -> Void) {
        service.request(.zonesCheck(request: request), completion: complition)
    }
    
    func performZonesAll(complition: @escaping (Result<[ZonesAllResponse], ApiErrorModel>) -> Void) {
        service.request(.zonesAll, completion: complition)
    }
    
    func performAddressesSuggest(_ request: AddressesSuggestRequest, complition: @escaping (Result<[AddressData], ApiErrorModel>) -> Void) {
        service.request(.addressesSuggest(request: request), completion: complition)
    }
    
    func performUserAddresses(complition: @escaping (Result<[UserAddressResponse], ApiErrorModel>) -> Void) {
        service.request(.addressesAll, completion: complition)
    }
    
    func performAddAddresses(_ request: UserAddressRequest, complition: @escaping (Result<UserAddressResponse, ApiErrorModel>) -> Void) {
        service.request(.addAddress(request: request), completion: complition)
    }
        
    //MARK: - OrderPromocode
    func performValidatePromocode(_ request: OrderPromocodeRequest, completion: @escaping (Result<OrderPromocodeResponse, ApiErrorModel>) -> Void) {
        service.request(.chekOrderPromocode(request: request), completion: completion)
    }
}
