//
//  HomeViewController.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 25/6/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

protocol HandleUserPrefLocation {
    func getSelectedLocation(selectedPlaceMark: MKPlacemark)
}

//protocol HandlePodBgImg {
//    func getPodBgImg(posts: [Post])
//}

class HomeViewController: UIViewController {
    
    let photoHelper = MGPhotoHelper()
    weak var selectedPlaceMark: MKPlacemark!
    
    @IBOutlet weak var whatTextfield: UITextField!
    @IBOutlet weak var whereTextfield: UITextField!
    @IBOutlet weak var whenTextfield: UITextField!
    @IBOutlet weak var bgImgView: UIImageView!
    
    var whereTextAppend: String = ""
    var didSetLocation: Bool = false
    
    var posts = [Post]()
    
    @IBOutlet weak var outCreatePod: UIButton!
    @IBOutlet weak var outAddBg: UIButton!
    
    private var datePicker : UIDatePicker?
    
    @IBAction func actAddBg(_ sender: UIButton) {
        photoHelper.presentActionSheet(from: self)
//        guard let bgImg = photoHelper.completionHandler else {
//            return
//        }
//
        
        //the bug is here
        
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            let lastIndex = posts.count - 1
            if posts.count > 1 {
                let post = posts[lastIndex]
                let imgURL = URL(string: post.imageURL)
                self.bgImgView.kf.setImage(with: imgURL)
            }
        }
    }
    
    @IBAction func actCreatePod(_ sender: UIButton) {
        print("Create Pod Button Pressed!")
    }
    
    @IBAction func addLocation(_ sender: Any) {
        print("Add Location Button Pressed!")
        
        if selectedPlaceMark != nil {
            //if location was already set
            
            guard let currTextVal = whereTextfield.text else {
                return
            }
            
            var userText: String = ""
            
            if currTextVal != "" {
                var subdividedStringArray = currTextVal.components(separatedBy: ", @")
                userText = subdividedStringArray[0]
                
                //things to do when user toggles off the location switch
                if subdividedStringArray.count > 1 {
                    subdividedStringArray[1] = ""
                    //set PlaceMark to nil again
                    selectedPlaceMark = nil
                    addImageForRightView(whereTextfield, iconName: Constants.Icons.addLocation)
                }
            }
            whereTextfield.text = "\(userText)"
            didSetLocation = false
        } else {
            //if location was not yet set
            performSegue(withIdentifier: "setUserLocation", sender: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set image for navigation header
        let logo = UIImage(named: Constants.Icons.logo)
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        // draw border for Textfields
        drawBorderForTextfield(whatTextfield)
        drawBorderForTextfield(whereTextfield)
        drawBorderForTextfield(whenTextfield)
        
        //corner radius for UIButton
        outCreatePod.layer.cornerRadius = 8
        outCreatePod.layer.borderWidth = 3
        outCreatePod.layer.borderColor = UIColor.cyan.cgColor
        
        /*figure out a way to show button being pressed, check out https://stackoverflow.com/questions/48317211/programmatically-added-button-not-showing-touch-feel-in-ios
        */
        
        
        //add location button on where textfield
        addImageForRightView(whereTextfield, iconName: Constants.Icons.addLocation)
        
        photoHelper.completionHandler = { image in
            
            //upload image
            PostService.create(for: image)
        }
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .dateAndTime
        let currDate = Date()
        datePicker?.minimumDate = currDate
        whenTextfield.inputView = datePicker
        
        datePicker?.addTarget(self, action: #selector(HomeViewController.datePickerValueChanged(_:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.viewTapped(gestureRecognizer:)))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker){
        
        // Create date formatter
        let dateFormatter: DateFormatter = DateFormatter()
        
        // Set date format
        dateFormatter.dateFormat = "MMM dd, yyyy hh:mm a"
        
        // Apply date format
        let selectedDate: String = dateFormatter.string(from: sender.date)
        
        whenTextfield.text = selectedDate
        print("Selected value \(selectedDate)")
    }
    
    func addImageForRightView(_ textField: UITextField, iconName: String) {
        let button = UIButton(type: .custom)
        
        let img: UIImage
        
        if selectedPlaceMark == nil {
            img = (UIImage(named: iconName)?.imageWithColor(color1: UIColor.lightGray))!
        } else {
            img = (UIImage(named: iconName)?.imageWithColor(color1: UIColor.blue))!
        }
        button.setImage(img, for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        button.frame = CGRect(x: CGFloat(textField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.addLocation), for: .touchUpInside)
        textField.rightView = button
        textField.rightViewMode = .always
    }
    
    func drawBorderForTextfield(_ textField: UITextField) {
        //set bottom border for textfield
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: textField.frame.size.height - width, width: textField.frame.size.width + 30, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        //self.view.setNeedsLayout()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationNavigationController = segue.destination as! UINavigationController
        let targetController = destinationNavigationController.topViewController as! MapViewController
        
        targetController.userLocationDelegate = self
    }

}

extension HomeViewController: HandleUserPrefLocation {
    
    func getSelectedLocation(selectedPlaceMark: MKPlacemark) {
        
        
        
        guard let title = selectedPlaceMark.title, let _ = selectedPlaceMark.name else {
            return
        }
        
        self.selectedPlaceMark = selectedPlaceMark
        
        print("***************** FINALLY! \(title) ******************")
        
        whereTextAppend = title
        guard var currTextVal = whereTextfield.text else {
            return
        }
        if currTextVal != "" {
            var subdividedStringArray = currTextVal.components(separatedBy: ", @")
            let userText = subdividedStringArray[0]
            var locationText  = ""
            
            if subdividedStringArray.count > 1 {
                subdividedStringArray[1] = whereTextAppend
                locationText = subdividedStringArray[1]
                currTextVal = "\(userText) , @ \(locationText)"
            }
            
        }
        whereTextfield.text = "\(currTextVal), @ \(whereTextAppend)"
        addImageForRightView(whereTextfield, iconName: Constants.Icons.addLocation)
    }
    
}


