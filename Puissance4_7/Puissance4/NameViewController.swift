//
//  NameViewController.swift
//  Puissance4
//
//  Created by Senebou Diarra on 09/04/2024.
//

import UIKit

class NameViewController: UIViewController {
    
    @IBOutlet weak var textField1: UITextView!
    
    @IBOutlet weak var textField2: UITextView!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func validateButtonPressed(_ sender: UIButton) {
  
        guard let text1 = textField1.text, !text1.isEmpty,
                  let text2 = textField2.text, !text2.isEmpty else {
                // Gestion de l'erreur si les champs de texte sont vides
                return
            }
            
        // Transition vers OptionViewController
        performSegue(withIdentifier: "NameToOptionSegue", sender: nil)
        

    }
    
    // Préparation pour la transition vers OptionViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NameToOptionSegue" {
            if let optionVC = segue.destination as? OptionViewController {
                optionVC.player1Name = textField1.text ?? ""
                optionVC.player2Name = textField2.text ?? ""
            }
        }
    }
    
   

}
