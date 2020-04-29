//
//  ManagedCache.swift
//  MyEssentialFeed
//
//  Created by Dim on 24.04.2020.
//  Copyright © 2020 Dmitriy Baklanov. All rights reserved.
//

import CoreData

@objc(ManagedCache)
 class ManagedCache: NSManagedObject {
    @NSManaged var timestamp: Date
    @NSManaged var feed: NSOrderedSet
}

extension ManagedCache {

     static func find(in context: NSManagedObjectContext) throws -> ManagedCache? {
        let request = NSFetchRequest<ManagedCache>(entityName: ManagedCache.entity().name!)
        request.returnsObjectsAsFaults = false
        return try context.fetch(request).first
    }

     static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedCache {
        try find(in: context).map(context.delete)
        return ManagedCache(context: context)
    }

     var localFeed: [LocalFeedImage] {
        return feed.compactMap { $0 as? ManagedFeedImage }.map { $0.local }
    }
}
