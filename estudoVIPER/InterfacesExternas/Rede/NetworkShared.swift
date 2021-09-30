//
//  NetworkShared.swift
//  estudoVIPER
//
//  Created by Roberto Edgar Geiss on 30/09/21.
//

import Foundation

class NetworkSubsystem
{
    let jsonQueue = DispatchQueue(label: "network-json", autoreleaseFrequency: .workItem)
    let resultQueue = DispatchQueue(label: "network-json", autoreleaseFrequency: .workItem)
    
    static let defaultInstance = NetworkSubsystem()
}
