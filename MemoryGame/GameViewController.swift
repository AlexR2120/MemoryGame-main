import UIKit

class GameViewController: UIViewController {
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    var allImages: [UIImage] = [
        UIImage(named: "ace")!,
        UIImage(named: "brook")!,
        UIImage(named: "shanks")!,
        UIImage(named: "luffy")!,
        UIImage(named: "sanji")!,
        UIImage(named: "zoro")!
    ]
    
    var imagesToMemorize: [UIImage] = []
    var playerName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.placeholder = "Ingrese nombre"
        
        setupImagesToMemorize()
    }

    func setupImagesToMemorize() {
        // Seleccionar 3 imágenes aleatorias del array allImages
        imagesToMemorize = allImages.shuffled().prefix(3).map { $0 }
        
        // Mostrar estas imágenes en los UIImageViews
        for (index, imageView) in imageViews.enumerated() {
            imageView.image = imagesToMemorize[index]
        }
    }

    @IBAction func playButtonTapped(_ sender: UIButton) {
        // Guardar el nombre ingresado
        if let name = nameTextField.text, !name.isEmpty {
            playerName = name
        } else {
            playerName = "Anónimo" // Nombre predeterminado si no se ingresa nada
        }
        
        performSegue(withIdentifier: "Game", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Game",
           let memoryGameVC = segue.destination as? MemoryGameViewController {
            memoryGameVC.imagesToMemorize = imagesToMemorize
            memoryGameVC.playerName = playerName
        }
    }
}
