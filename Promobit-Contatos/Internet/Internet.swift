//
//  Internet.swift
//  Promobit-Contatos
//
//  Created by Monitora on 22/04/21.
//

import Foundation

class Internet
{
    var reach: Reachability?
    
    static func isConnected() -> Bool {
        let networkReachability = Reachability.forInternetConnection()
        let networkStatus = networkReachability?.currentReachabilityStatus()
        return !(networkStatus == NetworkStatus.NotReachable)
    }
}
