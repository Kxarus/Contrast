//
//  APIEndPoint.swift
//  contrast
//
//  Created by Roman Kiruxin on 28.06.2023.
//

import Alamofire
import Foundation
import Moya

enum APIEndPoint {
    case userAuth(request: UserAuthRequest)
    case userVerify(request: UserVerifyRequest)
    case clientInvited(request: ClientInvitedRequest)
    case userRefresh
    case userLogout//(request: UserLogoutRequest)
    case fetchCatalog
    case chekOrderPromocode(request: OrderPromocodeRequest)
    
    //MARK: - MainDashboard
    case stories
    
    //MARK: - Favourites
    case getFavourites
    case addFavourites(request: FavouritesRequest)
    case removeFavourites(request: FavouritesRequest)
    
    //MARK: - Map
    case zonesGeolocate(request: CoordinateRequest)
    case zonesCheck(request: CoordinateRequest)
    case zonesAll
    case addressesSuggest(request: AddressesSuggestRequest)
    case addressesAll
    case addAddress(request: UserAddressRequest)
//    case removeAddress(request: )
//    case editAddress(request: )
}

struct TargetProvider: TargetType {
    var type: APIEndPoint
    private var defaults: UserDefaults
    
    init(with type: APIEndPoint) {
        self.type = type
        defaults = .standard
    }
    
    public mutating func handle(for type: APIEndPoint) {
        self.type = type
    }
}

extension TargetProvider {
    var baseHeaders: [String: String]? {
        var headers: [String: String] = [:]
        headers["X-DEVICE-TYPE"] = "IOS"
        return headers
    }

    var headers: [String: String]? {
        guard var newHeaders = baseHeaders else { return baseHeaders }

        switch type {
        case .userVerify:
            guard let deviceId = UserDefaultsWorker.fetchActiveDeviceToken() else { return baseHeaders! }
            newHeaders["X-DEVICE-ID"] = deviceId
        case .clientInvited,
                .stories,
                .getFavourites,
                .addFavourites,
                .removeFavourites,
                .zonesGeolocate,
                .zonesCheck,
                .zonesAll,
                .addressesSuggest,
                .addressesAll,
                .addAddress,
                .chekOrderPromocode,
                .zonesAll:
            guard let accessToken = UserDefaultsWorker.fetchActiveAccessToken() else {
                break
            }
            newHeaders["Authorization"] = accessToken
        case .userRefresh:
            guard let refreshToken = UserDefaultsWorker.fetchActiveRefreshToken() else {
                break
            }
            
            newHeaders["X-REFRESH-TOKEN"] = refreshToken
        default:
            newHeaders = baseHeaders!
        }
        
        return newHeaders
    }

    var apiVersion: String {
        switch type {
        default:
            return "/v1"
        }
    }

    var baseURL: URL {
        switch type {
        default:
            return URL(string: "http://\(Constants.apiDomain)/mobile\(apiVersion)")!
        }
    }

    var path: String {
        switch type {
        case .userAuth:
            return "/auth/send"
        case .userVerify:
            return "/auth/verify"
        case .userRefresh:
            return "/auth/refresh"
        case .userLogout:
            return "/auth/logout"
        case .chekOrderPromocode:
            return "/orders/validate"
        case .clientInvited:
            return "/client/invited"
            
        //MARK: - MainDashboard
        case .stories:
            return "/stories/all"
            
        //MARK: - Catalog
        case .fetchCatalog:
            return "/nomenclature/get"
            
        //MARK: - Favourites
        case .getFavourites:
            return "/nomenclature/favorites"
        case .addFavourites:
            return "/nomenclature/favorites/add"
        case .removeFavourites:
            return "/nomenclature/favorites/remove"
            
        //MARK: - Map
        case .zonesGeolocate:
            return "/zones/geolocate"
        case .zonesCheck:
            return "/zones/check"
        case .zonesAll:
            return "/zones/all"
        case .addressesSuggest:
            return "/client/addresses/suggest"
        case .addressesAll:
            return "/client/addresses/all"
        case .addAddress:
            return "/client/addresses/add"
        }
    }

    var method: Moya.Method {
        switch type {
        case .userAuth,
                .userVerify,
                .clientInvited,
                .addAddress,
                .chekOrderPromocode:
            return .post
        case .addFavourites:
            return .patch
        case .removeFavourites:
            return .delete
        default:
            return .get
        }
    }

    var methodDesc: String {
        switch method {
        case .post:
            return "POST"

        case .put:
            return "PUT"

        case .delete:
            return "DELETE"
            
        case .patch:
            return "PATCH"

        default:
            return "GET"
        }
    }

    var parameters: [String: Any]? {
        switch type {
        case .addFavourites(let request):
            return request.setupParams()
        case .zonesGeolocate(let request):
            return request.setupParams()
        case .zonesCheck(let request):
            return request.setupParams()
        case .addressesSuggest(let request):
            return request.setupParams()
        case .removeFavourites(let request):
            return request.setupParams()
        default:
            return nil
        }
    }

    var task: Task {
        switch type {
        case .userAuth(let request):
            return requestCompositeParameters(request)
        case .userVerify(let request):
            return requestCompositeParameters(request)
        case .clientInvited(let request):
            return requestCompositeParameters(request)
        case .addFavourites(let request),
             .removeFavourites(let request):
            return requestCompositeParameters(request)
        case .zonesGeolocate,
                .zonesCheck,
                .addressesSuggest:
            return .requestParameters(parameters: parameters ?? [:], encoding: URLEncoding())
        case .addAddress(let request):
            return requestCompositeParameters(request)
        case .chekOrderPromocode(let request):
            return requestCompositeParameters(request)
        default:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        return Data()
    }
}

// MARK: - Private methods

private extension TargetProvider {
    func requestCompositeParameters(_ body: Encodable) -> Task {
        var bodyDict: [String: Any] = [:]

        do {
            bodyDict = try body.asDictionary()
        } catch  let error {
            print(error.localizedDescription)
        }

        return .requestCompositeParameters(
            bodyParameters: bodyDict,
            bodyEncoding: JSONEncoding(),
            urlParameters: parameters ?? [:]
        )
    }
}

