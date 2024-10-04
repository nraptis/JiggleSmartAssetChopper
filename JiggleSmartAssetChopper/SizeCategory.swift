//
//  SizeCategoryButton.swift
//  JiggleSmartAssetChopper
//
//  Created by Nicky Taylor on 10/3/24.
//

import Foundation

enum SizeCategory: CaseIterable {
    
    case pad_0l
    case pad_1l
    case pad_2l

    case phone_po_0l
    case phone_po_1l
    case phone_po_2l
    
    case phone_ls_0l
    case phone_ls_1l
    case phone_ls_2l
    
    func getPosfix() -> String {
        switch self {
        case .pad_0l:
            "pad_0l"
        case .pad_1l:
            "pad_1l"
        case .pad_2l:
            "pad_2l"
        case .phone_po_0l:
            "phone_po_0l"
        case .phone_po_1l:
            "phone_po_1l"
        case .phone_po_2l:
            "phone_po_2l"
        case .phone_ls_0l:
            "phone_ls_0l"
        case .phone_ls_1l:
            "phone_ls_1l"
        case .phone_ls_2l:
            "phone_ls_2l"
        }
    }
    
    func getHeight(type: ImportType) -> Int {
        switch type {
        case .loose:
            switch self {
            case .pad_0l:
                return 252
            case .pad_1l:
                return 246 - 12
            case .pad_2l:
                return 162
            case .phone_po_0l:
                return 192
            case .phone_po_1l:
                return 186
            case .phone_po_2l:
                return 126
            case .phone_ls_0l:
                return 162
            case .phone_ls_1l:
                return 156
            case .phone_ls_2l:
                return 102
            }
        case .framed:
            switch self {
            case .pad_0l:
                return 252
            case .pad_1l:
                return 198 + 12
            case .pad_2l:
                return 120 + 6
            case .phone_po_0l:
                return 192
            case .phone_po_1l:
                return 168 + 6
            case .phone_po_2l:
                return 108 + 6
            case .phone_ls_0l:
                return 162
            case .phone_ls_1l:
                return 132 + 6
            case .phone_ls_2l:
                return 84 + 6
            }
        }
    }
}
