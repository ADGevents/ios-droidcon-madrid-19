//
//  DispatchingQueues.swift
//  droidconmadrid19Tests
//
//  Created by vjgarcia on 15/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation
@testable import droidconmadrid19

extension SyncQueue {
    static let stubbedMain: SyncQueue = SyncQueue(queue: DispatchQueue(label: "stubbed-main-queue"))
}
