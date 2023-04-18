//
//  RMAPICacheManager.swift
//  RickAndMorty
//
//  Created by MarkYu on 2023/4/14.
//

import Foundation

/// Manages in memory session scoped API caches
final class RMAPICacheManager {
    // API URL: Data
    
    private var cacheDictionary: [RMEndPoint: NSCache<NSString, NSData>] = [:]
    
    init() {
        setUpCache()
    }
    
    // MARK: - Public
    public func cachedResponse(for endpoint: RMEndPoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {return nil}
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: RMEndPoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionary[endpoint], let url = url else {return}
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    // MARK: - Private
    
    private func setUpCache() {
        RMEndPoint.allCases.forEach({
            cacheDictionary[$0] = NSCache<NSString, NSData>()
        })
    }
}
