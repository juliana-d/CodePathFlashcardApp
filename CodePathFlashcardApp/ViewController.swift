//
//  ViewController.swift
//  CodePathFlashcardApp
//
//  Created by Juliana Dudziak on 2/20/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
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
