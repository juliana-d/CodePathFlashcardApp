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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    func updateFlashcard (question: String, answer: String){
        questionLabel.text = question
        answerLabel.text = answer
        questionLabel.isHidden = false
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        if questionLabel.isHidden == true {
            questionLabel.isHidden = false
        } else {
            questionLabel.isHidden = true
        }
        
        }
      //  questionLabel.isHidden = true
        
}
