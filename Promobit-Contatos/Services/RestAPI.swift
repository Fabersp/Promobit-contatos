//
//  RestAPI.swift
//  Promobit-Contatos
//
//  Created by Monitora on 20/04/21.
//

import Foundation
import Alamofire

class RestAPI {
    
    static func getListaContatos(ordenacao: String, callback: @escaping (DataResponse<Any, AFError>) -> ()) {
        
        let url = "https://5ff85fad10778b0017043359.mockapi.io/api/contatos?\(ordenacao)"
        AF.request(url).responseJSON(completionHandler: { result in callback(result) })
        
    }
    static func postContato(body: [String:String], callback: @escaping (DataResponse<Any, AFError>) -> ()) {
    
        let url = "https://5ff85fad10778b0017043359.mockapi.io/api/contatos"
        AF.request(url, method: .post, parameters: body).responseJSON(completionHandler: {
            response in
            callback(response)
        })
    }
    static func updateContato(id: String, body: [String:String], callback: @escaping (DataResponse<Any, AFError>) -> ()) {
        
        let url = "https://5ff85fad10778b0017043359.mockapi.io/api/contatos/\(id)"
        
        AF.request(url, method: .put, parameters: body).responseJSON(completionHandler: {
            response in
            callback(response)
        })

    }
    static func deleteContato(id: String, callback: @escaping (DataResponse<Any, AFError>) -> ()) {
        
        let url = "https://5ff85fad10778b0017043359.mockapi.io/api/contatos/\(id)"
        AF.request(url, method: .delete).responseJSON(completionHandler: {
            response in
            callback(response)
        })
    }
    
}

