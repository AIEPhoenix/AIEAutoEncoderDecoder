//
//  Bone.swift
//  AutoEncodeDecodeExample
//
//  Created by BrianLee on 16/3/25.
//  Copyright © 2016年 BrianLee. All rights reserved.
//

import UIKit

class Bone: NSObject {
    var taste: String?
    override var description: String {
        let keys = ["taste"]
        return dictionaryWithValuesForKeys(keys).description
    }
}
