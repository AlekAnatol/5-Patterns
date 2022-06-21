//
//  ResultsViewController.swift
//  Lesson_1_2
//
//  Created by Екатерина Алексеева on 19.06.2022.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var resultsTableView: UITableView!
    
    var results = [Result]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
    }
    
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

extension ResultsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        let result = results[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        cell.textLabel?.text = dateFormatter.string(from: result.date)
        cell.detailTextLabel?.text = "\(result.percentOfAnswers) %"
        return cell
    }
}
