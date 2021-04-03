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
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    // array to hold flashcards of type Flashcard
    var flashcards = [Flashcard]()
   
    struct Flashcard {
        var question: String
        var answer: String
    }
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.layer.cornerRadius = 30.0
        answerLabel.layer.cornerRadius = 30.0
        card.layer.cornerRadius = 30.0
        questionLabel.clipsToBounds = true
        answerLabel.clipsToBounds = true
        card.layer.shadowRadius = 20.0
        card.layer.shadowOpacity = 0.3
        
        readSavedFlashcards()

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if flashcards.count == 0 {
            performSegue(withIdentifier: "newFlashcard", sender: self)
            //updateFlashcard(question: "Where was Edgar Allan Poe born?", answer: "Boston, MA")
                    }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //start with flashcard invisible and smaller
        card.alpha = 0.0
        card.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        //Animation
        UIView.animate (withDuration: 1.2, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.card.alpha = 1.0
            self.card.transform = CGAffineTransform.identity
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    
    func updateNextPrevButtons() {
        if currentIndex==flashcards.count - 1 {
            nextButton.isEnabled = false
            //nextButton.isHidden = true
        } else {
                nextButton.isEnabled = true
                //nextButton.isHidden = false
            }
        if currentIndex==0 {
            previousButton.isEnabled = false
            //previousButton.isHidden = true
        } else {
            previousButton.isEnabled = true
            //previousButton.isHidden = false
        }
        }
    
    func updateFlashcard (question: String, answer: String){
        let flashcard = Flashcard(question: question, answer: answer)
        questionLabel.text = flashcard.question
        answerLabel.text = flashcard.answer
       
        // add flashcard to array
        flashcards.append(flashcard)
        print("😎 added new flashcard")
        print("we now have \(flashcards.count) flashcards")
       
        
        // update current index
        currentIndex = flashcards.count - 1
        print("our current index is \(currentIndex)")
        
        // update buttons
        updateNextPrevButtons()
        
        // save new flashcard to disk
        saveAllFlashcardsToDisk()
        
        // make sure question always shows first when returning to screen
        questionLabel.isHidden = false

    }
    
    func updateLabels() {
        let currentFlashcard = flashcards[currentIndex]
        
        questionLabel.text = currentFlashcard.question
        answerLabel.text = currentFlashcard.answer
    }
    
    func saveAllFlashcardsToDisk(){
        // flashcard array to dictionary array
        let dictionaryArray = flashcards.map { (card) -> [String: String] in return ["question": card.question, "answer": card.answer]
        }
        
        // save array to disk
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // log saving of flashcards
        print("🎉 Flashcards saved to UserDefaults")
    }
        
    
    func readSavedFlashcards(){
       
        // read dictionary array from disk if any
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]] {
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
    
    func flipFlashcard(){
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight) {
            if self.questionLabel.isHidden == true {
                self.questionLabel.isHidden = false
            } else {
                self.questionLabel.isHidden = true
        }
        }
    }
    
    func animateCardOut(x: Int){
        UIView.animate(withDuration: 0.2, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(x), y: 0.0)
        }, completion: { finished in
            if x == Int(-300.0){
                self.animateCardIn(x:Int(300.0))
            }
            if x == Int(300.0){
                self.animateCardIn(x: Int(-300.0))
            }
            self.updateLabels()
        }
        )
    }
    
    func animateCardIn(x: Int){
        card.transform = CGAffineTransform.identity.translatedBy(x: CGFloat(x), y: 0.0)
        UIView.animate(withDuration: 0.2) {
            self.card.transform = CGAffineTransform.identity
        }
    }

    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        flipFlashcard()
        
        //questionLabel.isHidden = true
    }
        
    @IBAction func didTapOnPrevious(_ sender: Any) {
        currentIndex = currentIndex - 1
        animateCardOut(x: Int(300.0))
        if questionLabel.isHidden == true {
            questionLabel.isHidden = false
        }
        updateNextPrevButtons()
        
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex + 1
        animateCardOut(x: Int(-300.0))
        if questionLabel.isHidden == true {
            questionLabel.isHidden = false
        }
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        
        let alert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in self.deleteCurrentFlashcard()
        }
        alert.addAction(deleteAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        if flashcards.count != 1 {
            flashcards.remove(at: currentIndex)
        }
        if currentIndex > flashcards.count - 1 {
            currentIndex = flashcards.count - 1
        }
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
}
