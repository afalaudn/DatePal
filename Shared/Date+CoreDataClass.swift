//
//  Date+CoreDataClass.swift
//  DatePal
//
//  Created by Afif Alaudin on 26/05/24.
//
//

import Foundation
import CoreData

// Kencan is TopicSet
@objc(Kencan)
public class Kencan: NSManagedObject {
    @NSManaged public var topicName: String?
    @NSManaged public var topicList: String?
    @NSManaged public var topicCategory: String?

}
