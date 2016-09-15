//
//  Friend+CoreDataProperties.swift
//  Friends
//
//  Created by Philip on 9/15/16.
//  Copyright © 2016 Philip Vo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Friend {

    @NSManaged var name: String?
    @NSManaged var desc: String?
    @NSManaged var imgurl: String?

}
