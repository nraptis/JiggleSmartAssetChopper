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
}

struct ImportName {
    let partial: String
    let replace: String
    let type: ImportType
}
