//
//  Photo.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 24.06.2022.
//

import Foundation
import UIKit

struct Photo: ViewModelProtocol {
    let ownerID: Int
    let photo: UIImage?
    let likesCount: Int
}
