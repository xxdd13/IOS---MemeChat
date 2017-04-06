/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import Firebase
import Foundation
import Gifu


class LoginViewController: UIViewController {
  @IBOutlet weak var imageView: GIFImageView!
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet var bottomLayoutGuideConstraint: NSLayoutConstraint!
  
    var currentGIFName: String = "cat" {
        didSet {
            imageView.animate(withGIFNamed: currentGIFName)
        }
    }
    
    @IBAction func toggleAnimation(_ sender: AnyObject) {
        if imageView.isAnimatingGIF {
            imageView.stopAnimatingGIF()
        } else {
            imageView.startAnimatingGIF()
        }
    }
    
    @IBAction func swapImage(_ sender: AnyObject) {
        switch currentGIFName {
        case "cat":
            currentGIFName = "cat"
        default:
            currentGIFName = "cat"
        }
    }
    

    
    
  
  override func viewWillAppear(_ animated: Bool) {
    imageView.animate(withGIFNamed: currentGIFName)
    super.viewWillAppear(animated)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShowNotification(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHideNotification(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    imageView.prepareForReuse()
    super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
  }
  
  @IBAction func loginDidTouch(_ sender: AnyObject) {
    if nameField?.text != "" { // 1
        FIRAuth.auth()?.signInAnonymously(completion: { (user, error) in // 2
            if let err = error { // 3
                print(err.localizedDescription)
                return
            }
            
            self.performSegue(withIdentifier: "LoginToChat", sender: nil) // 4
        })
    }
  }
  
  // MARK: - Notifications
  
  func keyboardWillShowNotification(_ notification: Notification) {
    let keyboardEndFrame = ((notification as NSNotification).userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    let convertedKeyboardEndFrame = view.convert(keyboardEndFrame, from: view.window)
    print("1111111")
    print(bottomLayoutGuideConstraint.constant)
    print("2222222")
    print(view.bounds.maxY)
    print("333333")
    print(convertedKeyboardEndFrame.minY)
    bottomLayoutGuideConstraint.constant = view.bounds.maxY - convertedKeyboardEndFrame.minY
  }
  
  func keyboardWillHideNotification(_ notification: Notification) {
    bottomLayoutGuideConstraint.constant = 48
  }
  // MARK: Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    let navVc = segue.destination as! UINavigationController // 1
    let channelVc = navVc.viewControllers.first as! ChannelListViewController // 2
    
    channelVc.senderDisplayName = nameField?.text // 3
  }
    
    
}
