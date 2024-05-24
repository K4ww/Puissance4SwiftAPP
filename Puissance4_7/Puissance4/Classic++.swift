//
//  Classic++.swift
//  Puissance4
//
//  Created by Senebou Diarra on 09/04/2024.
//

import UIKit
import Foundation

class Classic__: UIViewController {
    // Outlets pour les images des joueurs
    @IBOutlet weak var Joueur1: UIImageView!
    @IBOutlet weak var joueur2: UIImageView!
        
    // Outlets pour les noms des joueurs
    @IBOutlet weak var joueurNom1: UILabel!
    @IBOutlet weak var joueurNom2: UILabel!
    
    // Outlets pour les compteurs de temps des joueurs
    @IBOutlet weak var Joueur1Timer: UIProgressView!
    @IBOutlet weak var Joueur2Timer: UIProgressView

    // Variables pour suivre le temps restant de chaque joueur
    var joueur1TimeRemaining: Float = 10.0
    var joueur2TimeRemaining: Float = 10.

    // Timer pour gérer le décompte du temps
    var timer: Timer?

    // Variable pour suivre le joueur actuel (1 pour Joueur1, 2 pour Joueur2)
    var currentPlayer: Int = 1 // Pour suivre le joueur actuel

    // Noms des joueurs
    var player1Name: String?
    var player2Name: String?
    var selectedOption: Int = 0 // Cette propriété stockera l'option sélectionnée
    
    var totalClics : Int = 0 // Nombre total de clics 
    var previousRandom: Int = 0

    // Tableau contenant les cellules du jeu
    @IBOutlet var cellules: [UIImageView]!

    // Fonction pour démarrer le minuteur
    func startTimer() {
        // Créer un minuteur qui se déclenche toutes les 1 seconde
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
            // Décrémenter le temps restant pour le joueur actif
            if currentPlayer == 1 {
                joueur1TimeRemaining -= 1.0
                Joueur1Timer.progress = joueur1TimeRemaining / 10.0
                if joueur1TimeRemaining <= 0 {
                    // Si le temps du joueur 1 est écoulé, recharger son timer et passer au joueur 2
                    joueur1TimeRemaining = 10.0
                    Joueur1Timer.progress = 1.0
                    currentPlayer = 2
                }
            } else {
                joueur2TimeRemaining -= 1.0
                Joueur2Timer.progress = joueur2TimeRemaining / 10.0
                if joueur2TimeRemaining <= 0 {
                    // Si le temps du joueur 2 est écoulé, recharger son timer et passer au joueur 1
                    joueur2TimeRemaining = 10.0
                    Joueur2Timer.progress = 1.0
                    currentPlayer = 1
                }
            }
        }
    //préciser le joueur qui joue
    func trouverJoueurActuel(totalClics: Int) -> String {
        if totalClics%2 == 0 {
            Joueur1Timer.progress = 1.0
            joueur1TimeRemaining = 10.0
            return "Joueur 2"
        } else {
            return "Joueur 1"
        }
    }
    // Fonction pour mettre à jour les vues des joueurs
    func mettreAJourVuesJoueurs(joueurActuel: String) {
        // Afficher l'image du joueur actuel
        if joueurActuel == "Joueur 1" {
            Joueur1.isHidden = true
            joueur2.isHidden = false
        } else {
            Joueur1.isHidden = false
            joueur2.isHidden = true
        }
    }
    //vérifier les alignements
    func vérifierAlignementHorizontal() {
        // Définir les couleurs des joueurs
        let couleurJoueur1 = UIColor.red
        let couleurJoueur2 = UIColor.yellow
        
        // Parcourir les lignes du bas vers le haut
        for row in 0..<6 {
            // Parcourir les colonnes de gauche à droite
            for col in 0..<4 {
                let index = row * 7 + col
                let cellule1 = cellules[index]
                let cellule2 = cellules[index + 1]
                let cellule3 = cellules[index + 2]
                let cellule4 = cellules[index + 3]
                
                // Vérifier si les quatre cellules adjacentes ont la même couleur (pour le joueur 1 ou le joueur 2)
                if cellule1.tintColor == couleurJoueur1 && cellule2.tintColor == couleurJoueur1 && cellule3.tintColor == couleurJoueur1 && cellule4.tintColor == couleurJoueur1 {
                    afficherAlerte(gagnant: joueurNom1.text!)
                    return
                } else if cellule1.tintColor == couleurJoueur2 && cellule2.tintColor == couleurJoueur2 && cellule3.tintColor == couleurJoueur2 && cellule4.tintColor == couleurJoueur2 {
                    afficherAlerte(gagnant: joueurNom2.text!)
                    return
                }
            }
        }
    }
    func vérifierAlignementVertical() {
        // Définir les couleurs des joueurs
        let couleurJoueur1 = UIColor.red
        let couleurJoueur2 = UIColor.yellow
        
        // Parcourir les colonnes de gauche à droite
        for col in 0..<7 {
            // Parcourir les lignes du bas vers le haut
            for row in 0..<3 {
                let index = row * 7 + col
                let cellule1 = cellules[index]
                let cellule2 = cellules[index + 7]
                let cellule3 = cellules[index + 14]
                let cellule4 = cellules[index + 21]
                
                // Vérifier si les quatre cellules verticales ont la même couleur (pour le joueur 1 ou le joueur 2)
                if cellule1.tintColor == couleurJoueur1 && cellule2.tintColor == couleurJoueur1 && cellule3.tintColor == couleurJoueur1 && cellule4.tintColor == couleurJoueur1 {
                    afficherAlerte(gagnant: joueurNom1.text!)
                    return
                } else if cellule1.tintColor == couleurJoueur2 && cellule2.tintColor == couleurJoueur2 && cellule3.tintColor == couleurJoueur2 && cellule4.tintColor == couleurJoueur2 {
                    afficherAlerte(gagnant: joueurNom2.text!)
                    return
                }
            }
        }
    }

    func vérifierAlignementDiagonal() {
        // Définir les couleurs des joueurs
        let couleurJoueur1 = UIColor.red
        let couleurJoueur2 = UIColor.yellow
        
        // Vérifier les diagonales de haut à gauche à bas à droite
        for row in 0..<3 {
            for col in 0..<4 {
                let index = row * 7 + col
                let cellule1 = cellules[index]
                let cellule2 = cellules[index + 8]
                let cellule3 = cellules[index + 16]
                let cellule4 = cellules[index + 24]
                
                // Vérifier si les quatre cellules diagonales ont la même couleur (pour le joueur 1 ou le joueur 2)
                if cellule1.tintColor == couleurJoueur1 && cellule2.tintColor == couleurJoueur1 && cellule3.tintColor == couleurJoueur1 && cellule4.tintColor == couleurJoueur1 {
                    afficherAlerte(gagnant: joueurNom1.text!)
                    return
                } else if cellule1.tintColor == couleurJoueur2 && cellule2.tintColor == couleurJoueur2 && cellule3.tintColor == couleurJoueur2 && cellule4.tintColor == couleurJoueur2 {
                    afficherAlerte(gagnant: joueurNom2.text!)
                    return
                }
            }
        }
        
        // Vérifier les diagonales de haut à droite à bas à gauche
        for row in 0..<3 {
            for col in 3..<7 {
                let index = row * 7 + col
                let cellule1 = cellules[index]
                let cellule2 = cellules[index + 6]
                let cellule3 = cellules[index + 12]
                let cellule4 = cellules[index + 18]
                
                // Vérifier si les quatre cellules diagonales ont la même couleur (pour le joueur 1 ou le joueur 2)
                if cellule1.tintColor == couleurJoueur1 && cellule2.tintColor == couleurJoueur1 && cellule3.tintColor == couleurJoueur1 && cellule4.tintColor == couleurJoueur1 {
                    afficherAlerte(gagnant: joueurNom1.text!)
                    return
                } else if cellule1.tintColor == couleurJoueur2 && cellule2.tintColor == couleurJoueur2 && cellule3.tintColor == couleurJoueur2 && cellule4.tintColor == couleurJoueur2 {
                    afficherAlerte(gagnant: joueurNom2.text!)
                    return
                }
            }
        }
    }
    //recharger les timer à chaque tour de jeu pour chaque joueur
    func resetTimers() {
        joueur1TimeRemaining = 10.0
        joueur2TimeRemaining = 10.0
        Joueur1Timer.progress = 1.0
        Joueur2Timer.progress = 1.0
        currentPlayer = 1
        Joueur1.isHidden = false
        joueur2.isHidden = true
        startTimer()
    }
    // une alerte s'affiche quand une partie termine
    func afficherAlerte(gagnant: String) {
        let alerte = UIAlertController(title: "Partie terminée", message: "\(gagnant) a gagné !", preferredStyle: .alert)
        let action = UIAlertAction(title: "Nouvelle Partie", style: .default) { (_) in
            // Réinitialiser le jeu
            for imageView in self.cellules {
                imageView.tintColor = UIColor.white
            }
            self.resetTimers() // Réinitialiser les timers
        }
        alerte.addAction(action)
        present(alerte, animated: true, completion: nil)
    }
    //quand un joueur touche l'écran
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        //on récupere la position de touche du joueur
        let touchPoint = touch.location(in: self.view)
        
        // Parcourir les UIImageView pour vérifier si le joueur a bien touché un cercle
        for imageView in cellules {
            //si le joueur a bien touché un cercle
            if imageView.frame.contains(touchPoint) {
                    totalClics += 1
                    //on récupére le joueur qui doit jouer
                    let joueurActuel = trouverJoueurActuel(totalClics: totalClics)
                    // Appel de la fonction lors du changement de joueur
                    mettreAJourVuesJoueurs(joueurActuel: joueurActuel) // Par exemple, pour le joueur 1
                    //on choisie un index
                    let randomNumber = Int.random(in: 0..<42)
                if totalClics % 3 == 0 {
                    let randomNumber = Int.random(in: 0...41)
                    let randomNumber2 = Int.random(in: 0...41)
                    if cellules[randomNumber2].tintColor == UIColor.black {
                        cellules[randomNumber2].tintColor = UIColor.white
                    }
                    if cellules[randomNumber].tintColor == UIColor.white {
                        cellules[randomNumber].tintColor = UIColor.black
                    }
            
            }
                
                    // Trouver la position de l'ImageView cliquée pour faire les modifications nécessaires
                    if let index = cellules.firstIndex(of: imageView) {
                            // trouver la colonne dans laquelle l'ImageView cliquée est située
                            let colonne = index % 7
                            // parcourir les lignes dans une colonne pour voir quelle cellule on doit colorer
                            for l in stride(from: 5, through: 0, by: -1){
                                let changer = l * 7 + colonne
                                // si la cellule est déjà colorée alors on monte à la cellule audessus
                                if cellules[changer].tintColor != UIColor.white {
                                    continue
                                }//sinon non change sa couleur tout dépend le joueur du moment
                                else{
                                    if currentPlayer == 1{
                                        joueur1TimeRemaining = 10.0
                                        Joueur1Timer.progress = 1.0
                                        currentPlayer = 2
                                        cellules[changer].tintColor = UIColor.red // Changez la couleur en rouge
                                        break
                                    }else {
                                        joueur2TimeRemaining = 10.0
                                        Joueur2Timer.progress = 1.0
                                        currentPlayer = 1
                                        cellules[changer].tintColor = UIColor.yellow// Changez la couleur en jaune
                                        break
                                    }
                                    
                                }
                            }
                        
                    }
                    return
                
                
            }
        }
        
    }
    //à la fin de chaque touche d'écran on vérifie s'il y a un joueur gagnant
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesEnded(touches, with: event)
        
        vérifierAlignementHorizontal()
        vérifierAlignementDiagonal()
        vérifierAlignementVertical()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //récupération des noms des joueurs
        if player1Name != "" && player2Name != "" {
            joueurNom1.text = player1Name
            joueurNom2.text = player2Name

        } else {
            joueurNom1.text = "Joueur 1"
            joueurNom2.text = "Joueur 2"
        }
        // Initialiser les vues de progression avec une valeur maximale de 10 secondes
                Joueur1Timer.progress = 1.0
                Joueur2Timer.progress = 1.0
                
                // Lancer le minuteur
                startTimer()
        mettreAJourVuesJoueurs(joueurActuel: "Joueur 2")
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
