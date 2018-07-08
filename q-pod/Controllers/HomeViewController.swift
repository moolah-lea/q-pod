//
//  HomeViewController.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 25/6/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let photoHelper = MGPhotoHelper()
    
    @IBOutlet weak var whatTextfield: UITextField!
    @IBOutlet weak var whereTextfield: UITextField!
    @IBOutlet weak var whenTextfield: UITextField!
    
    @IBOutlet weak var outCreatePod: UIButton!
    @IBOutlet weak var outAddBg: UIButton!
    
    private var datePicker : UIDatePicker?
    
    @IBAction func actAddBg(_ sender: UIButton) {
        photoHelper.presentActionSheet(from: self)
    }
    
    @IBAction func actCreatePod(_ sender: UIButton) {
        print("Create Pod Button Pressed!")
    }
    
    @IBAction func addLocation(_ sender: Any) {
        print("Add Location Button Pressed!")
        
        performSegue(withIdentifier: "setLocationSegue", sender: nil)

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
        let img = UIImage(named: iconName)?.imageWithColor(color1: UIColor.lightGray)
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
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
