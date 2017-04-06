
import Foundation
import UIKit
import Photos
import Firebase
import JSQMessagesViewController


class ShowMediaViewController: UIViewController {
    var image: UIImage?
    var titreText: String!
    @IBOutlet var imageView: UIImageView!
    //i tried @IBOutlet weak var imageView: UIImageView! but didn't work
    @IBOutlet weak var titre: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if image != nil {
            
            //crashes here, because imageView is nil
            imageView.image = image
        } else {
            print("image not found")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
}
