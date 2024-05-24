//
//  OptionViewController.swift
//  Puissance4
//
//  Created by Senebou Diarra on 09/04/2024.
//

import UIKit

class OptionViewController: UIViewController {
    
    
    var player1Name: String = ""
    var player2Name: String = ""
        
    // Définissez l'action à effectuer lorsqu'un bouton est pressé
    @IBAction func gameButtonPressed(_ sender: UIButton) {
        // Vous pouvez transmettre l'option sélectionnée à la vue de jeu
        // par exemple, à l'aide d'une propriété dans la vue de jeu,
            // puis effectuer la transition vers cette vue de jeu.
        performSegue(withIdentifier: "OptionToGameSegue", sender: sender.tag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "OptionToGameSegue" {
            
            if let nbLigneViewController = segue.destination as? NombreDeLigneViewController {
                // Transmettez les noms des joueurs à la vue de jeu sélectionnée
                nbLigneViewController.player1Name = player1Name
                nbLigneViewController.player2Name = player2Name
                // Transmettez l'option sélectionnée
                if let selectedOption = sender as? Int {
                    nbLigneViewController.selectedOption = selectedOption
                }
            }
            
            if let classicPPViewController = segue.destination as? Classic__ {
                // Transmettez les noms des joueurs à la vue de jeu sélectionnée
                classicPPViewController.player1Name = player1Name
                classicPPViewController.player2Name = player2Name
                // Transmettez l'option sélectionnée
                if let selectedOption = sender as? Int {
                    classicPPViewController.selectedOption = selectedOption
                }
            }
            
            if let classicViewController = segue.destination as? ViewController {
                // Transmettez les noms des joueurs à la vue de jeu sélectionnée
                classicViewController.player1Name = player1Name
                classicViewController.player2Name = player2Name
                // Transmettez l'option sélectionnée
                if let selectedOption = sender as? Int {
                    classicViewController.selectedOption = selectedOption
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
