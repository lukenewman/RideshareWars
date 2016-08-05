//
//  LyftAPI.swift
//  RideshareWars
//
//  Created by Luke Newman on 8/2/16.
//  Copyright © 2016 Luke Newman. All rights reserved.
//

import Alamofire

public class LyftAPI {
    
    public static let baseURL: String = "https://api.lyft.com/v1/"
    
    public enum Endpoints {
        case GetCost(Float, Float)
        
        public var method: Alamofire.Method {
            switch self {
            case .GetCost: return Alamofire.Method.GET
            }
        }
        
        public var path: String {
            switch self {
            case .GetCost: return baseURL + "cost"
            }
        }
        
        public var parameters: [String : Any] {
            var parameters = ["format" : "json"]
            
            switch self {
            case .GetCost(let lat, let lng):
                parameters["start_lat"] = lat
                parameters["start_lng"] = lng
                return parameters
            }
        }
    }
    
    public static func request(endpoint : LyftAPI.Endpoints, completion: Response<AnyObject, NSError> -> Void) -> Request {
        let request = Manager.sharedInstance.request(
            endpoint.method,
            endpoint.path,
            parameters: endpoint.parameters,
            encoding: .URL,
            headers: nil
            ).responseJSON { response in
                
                if (response.result.error != nil) {
                    completion(response)
                } else {
                    completion(response)
                }
                
        }
        
        return request
    }
}

