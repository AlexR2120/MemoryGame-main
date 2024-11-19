import UIKit

class MemoryGameViewController: UIViewController {
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!

    @IBOutlet weak var finishButton: UIButton!

    var selectedImages = [Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGameImages()
        setupGestures()
        finishButton.isEnabled = false
        finishButton.alpha = 0.6
    }

    func setupGameImages() {
        let shuffledIndexes = (0..<imageList.count).shuffled()
        image1.image = imageList[shuffledIndexes[0]]
        image2.image = imageList[shuffledIndexes[1]]
        image3.image = imageList[shuffledIndexes[2]]
        image4.image = imageList[shuffledIndexes[3]]
        image5.image = imageList[shuffledIndexes[4]]
        image6.image = imageList[shuffledIndexes[5]]

        image1.tag = shuffledIndexes[0]
        image2.tag = shuffledIndexes[1]
        image3.tag = shuffledIndexes[2]
        image4.tag = shuffledIndexes[3]
        image5.tag = shuffledIndexes[4]
        image6.tag = shuffledIndexes[5]
    }

    func setupGestures() {
        let images = [image1, image2, image3, image4, image5, image6]
        for image in images {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
            image?.addGestureRecognizer(tapGesture)
            image?.isUserInteractionEnabled = true
        }
    }

    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedImage = sender.view as? UIImageView else { return }

        if selectedImages.contains(tappedImage.tag) {
            return // Ignore already selected images
        }

        selectedImages.append(tappedImage.tag)

        if selectedImageIndexes.contains(tappedImage.tag) {
            currentScore += 25
        } else {
            currentScore -= 15
        }

        tappedImage.alpha = 0.5

        if selectedImages.count == 3 {
            finishButton.isEnabled = true
            finishButton.alpha = 1.0
        }
    }

    @IBAction func finishGame(_ sender: UIButton) {
        performSegue(withIdentifier: "Results", sender: nil)
    }
}
