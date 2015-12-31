//
//  QueryCondition.swift
//  JDUserDemo
//
//  Created by O2.LinYi on 15/12/31.
//  Copyright © 2015年 jd.com. All rights reserved.
//

import Foundation
import AVOSCloud

public enum QueryCondition{
    case equalTo([String: AnyObject]) // &&
    case notEqualTo([String: AnyObject]) // !
    case lessThan([String: AnyObject]) // <
    case greaterThan([String: AnyObject]) // >
}

public func convertQuery(querys: Array<QueryCondition>, query: AVQuery) -> AVQuery? {
    for var i = 0; i < querys.count; ++i{
        let Condition = querys[i]
        switch Condition{
        case .equalTo(let condition):
            for (k, v) in condition {
                query.whereKey(k, equalTo: v)
            }
        case .notEqualTo(let condition):
            for (k, v) in condition {
                query.whereKey(k, notEqualTo: v)
            }
        case .lessThan(let condition):
            for (k, v) in condition {
                query.whereKey(k, lessThan: v)
            }
        case .greaterThan(let condition):
            for (k, v) in condition {
                query.whereKey(k, greaterThan: v)
            }
        }
    }
    return query
}

