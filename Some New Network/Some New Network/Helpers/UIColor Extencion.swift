//
//  UIColor Extencion.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 24.06.2022.
//

import Foundation
import UIKit

/* В приложении используется два кастомных цвета, :
 1. заливка основного View розовым цветом на всех контроллерах приложения, что дает цвет верхним и нижним "ушкам"
 2. цвет тени в ячейках с круглой аватаркой (например: основная аватарка пользователя, фото друзей в контроллере с их списком, аватарка группы), цвет указан в файле AvatarView

 */
extension UIColor {
    static let brandPink = UIColor(red: 255.0/255.0, green: 221.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    static let shadowColor = UIColor(red: 146.0/255.0, green: 0.0/255.0, blue: 59.0/255.0, alpha: 1.0)
}
