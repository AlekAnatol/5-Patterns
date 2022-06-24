//
//  AllGroupsViewController+TableViewDelegate.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 13.01.2022.
//

import UIKit

extension AllGroupsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForCellTableView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
