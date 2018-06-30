//
//  HomeViewController.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 25/6/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var whatTextfield: UITextField!
    @IBOutlet weak var whereTextfield: UITextField!
    @IBOutlet weak var whenTextfield: UITextField!
    
    @IBOutlet weak var outCreatePod: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // set image for navigation header
        let logo = UIImage(named: "nav_logo.png")
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
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
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
