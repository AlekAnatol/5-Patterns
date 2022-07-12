//
//  LikesCounterControlView.swift
//  Some New Network
//
//  Created by Екатерина Алексеева on 20.01.2022.
//

import UIKit

protocol LikesCounterControlViewProtocol: AnyObject {
    func countIncrement(count: Int)
    func countDecrement(count: Int)
}

@IBDesignable class LikesCounterControlView: UIView {
    
    
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    
    
    private var view: UIView!
    
    weak var delegate: LikesCounterControlViewProtocol?
    
    var likeCounter = 0
    var isHeartEmpty = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func loadFromNib() -> UIView {
        let boundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "LikesCounterControlView", bundle: boundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {return UIView()}
        return view
    }
    
    func setup(){
        self.view = loadFromNib()
        self.view.frame = bounds
        self.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(self.view)
        countLabel.text = String(self.likeCounter)
    }
    
    func configure(count: Int) {
        self.likeCounter = count
        countLabel.text = String(self.likeCounter)
    }
    
    
    @IBAction func pressHeartButton(_ sender: Any) {
        if isHeartEmpty {
            self.likeCounter += 1
            UIView.transition(with: heartButton, duration: 0.5, options: [.transitionCrossDissolve]) {[weak self] in
                self?.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                
            } completion: { _ in
                UIView.transition(with: self.countLabel, duration: 2, options: [.transitionFlipFromTop]) {[weak self] in
                    self?.countLabel.text = String(self?.likeCounter ?? 0)
                } completion: { _ in
                    print("Heart added")
                }

            }
            self.delegate?.countIncrement(count: self.likeCounter)
            
            
        } else {
            self.likeCounter -= 1
            UIView.transition(with: heartButton, duration: 0.5, options: [.transitionCrossDissolve]) {[weak self] in
                self?.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
                
            } completion: { _ in
                UIView.transition(with: self.countLabel, duration: 2, options: [.transitionFlipFromBottom]) {[weak self] in
                    self?.countLabel.text = String(self?.likeCounter ?? 0)
                } completion: { _ in
                    print("Heart deleted")
                }

            }
            self.delegate?.countDecrement(count: self.likeCounter)
        }
        
        isHeartEmpty = !isHeartEmpty
    }
    
}
