import UIKit

class MemoryGameViewController: UIViewController {
    @IBOutlet var imageViews: [UIImageView]!
    @IBOutlet weak var finishButton: UIButton!
    
    var allImages: [UIImage] = [
        UIImage(named: "ace")!,
        UIImage(named: "brook")!,
        UIImage(named: "shanks")!,
        UIImage(named: "luffy")!,
        UIImage(named: "sanji")!,
        UIImage(named: "zoro")!
    ]
    
    var imagesToMemorize: [UIImage] = []
    var selectedImages: [UIImage] = []
    var score: Int = 0
    var playerName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGame()
    }

    func setupGame() {
        // Mostrar todas las imágenes para selección
        for (index, imageView) in imageViews.enumerated() {
            imageView.image = allImages[index]
            imageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            imageView.addGestureRecognizer(tapGesture)
        }
        finishButton.isHidden = true
    }

    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let tappedImageView = sender.view as? UIImageView, let selectedImage = tappedImageView.image {
            if selectedImages.contains(selectedImage) {
                return
            }
            if selectedImages.count < 3 {
                selectedImages.append(selectedImage)
                tappedImageView.alpha = 0.5 // Cambiar apariencia para indicar selección
            }
            if selectedImages.count == 3 {
                checkSelections()
                finishButton.isHidden = false
            }
        }
    }

    func checkSelections() {
        score = 0
        for image in selectedImages {
            if imagesToMemorize.contains(image) {
                score += 25 // 25 puntos por cada imagen correcta
            } else {
                score -= 10 // -10 puntos por cada imagen incorrecta
            }
        }
    }

    @IBAction func finishButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowResult", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResult",
           let resultVC = segue.destination as? ResultViewController {
            resultVC.currentScore = score
            resultVC.playerName = playerName
        }
    }
}
