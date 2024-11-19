import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        currentPlayer = Player()
        setupRandomImages()
        
        nameTextField.addTarget(self, action: #selector(nameEditingChanged), for: .editingChanged)
    }

    func setupInitialView() {
        playButton.isEnabled = false
        playButton.alpha = 0.6
    }

    func setupRandomImages() {
        var uniqueIndexes: Set<Int> = []
        while uniqueIndexes.count < 3 {
            uniqueIndexes.insert(Int.random(in: 0..<imageList.count))
        }
        let selectedIndexes = Array(uniqueIndexes)
        image1.image = imageList[selectedIndexes[0]]
        image2.image = imageList[selectedIndexes[1]]
        image3.image = imageList[selectedIndexes[2]]
        selectedImageIndexes = selectedIndexes
    }
    
    @objc func nameEditingChanged() {
            // Si el texto no está vacío, habilitar el botón
            if let name = nameTextField.text, !name.isEmpty {
                currentPlayer.name = name
                playButton.isEnabled = true
                playButton.alpha = 1.0
            } else {
                playButton.isEnabled = false
                playButton.alpha = 0.6
            }
        }

    @IBAction func playButtonPressed(_ sender: UIButton) {
        if let name = nameTextField.text, name.isEmpty {
            currentPlayer.name = "Anonimo"
        }
        performSegue(withIdentifier: "Game", sender: nil)
    }
}
