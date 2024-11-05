import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!

    var imagesToMemorize: [UIImage] = []
    var selectedImages: [UIImage] = []
    var allImages: [UIImage] = [
        UIImage(named: "ace")!,
        UIImage(named: "brook")!,
        UIImage(named: "shanks")!,
        UIImage(named: "luffy")!,
        UIImage(named: "sanji")!,
        UIImage(named: "zoro")!
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayRandomImages()
    }
    
    func displayRandomImages() {
        imagesToMemorize = Array(allImages.shuffled().prefix(3))
        image1.image = imagesToMemorize[0]
        image2.image = imagesToMemorize[1]
        image3.image = imagesToMemorize[2]
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "Game", sender: nil)
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Game" {
            if let memoryGameVC = segue.destination as? MemoryGameViewController {
                memoryGameVC.imagesToMemorize = imagesToMemorize
            
            }
        }
    }
}
