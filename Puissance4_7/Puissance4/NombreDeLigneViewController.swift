//
//  NombreDeLigneViewController.swift
//  Puissance4
//
//  Created by Kawther Djouad on 05/04/2024.
//

import UIKit

class NombreDeLigneViewController: UIViewController {
    // Outlets pour les images des joueurs
    @IBOutlet weak var Joueur1: UIImageView!
    @IBOutlet weak var joueur2: UIImageView!

    // Outlets pour les noms des joueurs   
    @IBOutlet weak var joueurNom1: UILabel!
    @IBOutlet weak var joueurNom2: UILabel!
    
    // Outlets pour les compteurs de temps des joueurs
    @IBOutlet weak var Joueur1Timer: UIProgressView!
    @IBOutlet weak var Joueur2Timer: UIProgressView!

    // Variables pour suivre le temps restant de chaque joueur
    var joueur1TimeRemaining: Float = 10.0
    var joueur2TimeRemaining: Float = 10.0

    // Timer pour gérer le décompte du temps
    var timer: Timer?

    // Noms des joueurs
    var player1Name: String?
    var player2Name: String?
    var selectedOption: Int = 0 // Cette propriété stockera l'option sélectionnée

    // Variable pour suivre le joueur actuel (1 pour Joueur1, 2 pour Joueur2)
    var currentPlayer: Int = 1 // Pour suivre le joueur actuel
    var totalClics : Int = 0
    //Scores des joueurs
    var Score1 : Int = 0
    var Score2 : Int = 0

    // sauvegarder le début et la fin de chaque nouvelle ligne détéctée
    var prevstart: Int = 0
    var prevend: Int = 3
    
    @IBOutlet var cellules: [UIImageView]!
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
    
    //vérifier si la grille est complétés
     func verifierGrilleRemplie() -> Bool {
         for imageView in cellules {
             if imageView.tintColor == UIColor.white {
                 return false // Au moins une cellule est blanche, la grille n'est pas entièrement remplie
             }
         }
         return true // Toutes les cellules sont de couleur différente de blanc, la grille est remplie
     }
    
    //vérifier les alignements si la grille est complétées
    func vérifierAlignementHorizontal() {
        // Définir les couleurs des joueurs
        let couleurJoueur1 = UIColor.red
        let couleurJoueur2 = UIColor.yellow
        if verifierGrilleRemplie() == true {
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
                        Score1+=1
                    } else if cellule1.tintColor == couleurJoueur2 && cellule2.tintColor == couleurJoueur2 && cellule3.tintColor == couleurJoueur2 && cellule4.tintColor == couleurJoueur2 {
                        Score2+=1
                    }
                }
            }
            //Retourner le joueur gagnant tout dépend le score
            if Score1>Score2 {afficherAlerte(gagnant: joueurNom1.text!,score: Score1)}
            else if Score2>Score1 {afficherAlerte(gagnant: joueurNom2.text!,score: Score2)}
            else if Score1 == Score2 {afficherAlerte(gagnant: "Égalité", score: 0)}
        }
        
    }
    //recharger les timer à chaque chanegement de tour de joueur
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
    func afficherAlerte(gagnant: String,score: Int) {
        if gagnant == "Égalité" {
            let alerte = UIAlertController(title: "Partie terminée",message: "Égalité !!", preferredStyle: .alert)
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
        let alerte = UIAlertController(title: "Partie terminée", message: "\(gagnant) a gagné avec un score de \(score) !", preferredStyle: .alert)
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
                                }//sinon non change sa couleur
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
    //à la fin de chaque touche d'écran on vérifie s'il y a une ligne crée par un joueur
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesEnded(touches, with: event)
       vérifierAlignementHorizontal()
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Récupération des noms des joueurs
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
