//
//  Date+CoreDataProperties.swift
//  DatePal
//
//  Created by Afif Alaudin on 26/05/24.
//
//

import Foundation
import CoreData


extension Kencan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kencan> {
        return NSFetchRequest<Kencan>(entityName: "Kencan")
    }

//    @NSManaged public var topicName: String?
//    @NSManaged public var topicList: String?
//    @NSManaged public var topicCategory: String?

}

extension Kencan : Identifiable {

}
