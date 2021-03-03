//
//  ViewController.swift
//  CodePathFlashcardApp
//
//  Created by Juliana Dudziak on 2/20/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.layer.cornerRadius = 30.0
        answerLabel.layer.cornerRadius = 30.0
        card.layer.cornerRadius = 30.0
        questionLabel.clipsToBounds = true
        answerLabel.clipsToBounds = true
        card.layer.shadowRadius = 20.0
        card.layer.shadowOpacity = 0.3
        
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        if questionLabel.isHidden == false {
            questionLabel.isHidden = true
        } else {
            questionLabel.isHidden = false
        }
        }
      //  questionLabel.isHidden = true
        
}
