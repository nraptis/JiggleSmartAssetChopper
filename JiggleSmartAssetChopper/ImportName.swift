//
//  ImportName.swift
//  JiggleSmartAssetChopper
//
//  Created by Nicky Taylor on 10/3/24.
//

import Foundation

enum ImportType {
    case loose
    case framed
    case accessory
}

struct ImportName {
    let inputPrefix: String
    let outputPrefix: String
    let name: String
    let type: ImportType
}
