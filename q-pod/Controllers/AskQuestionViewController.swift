//
//  AskQuestionViewController.swift
//  q-pod
//
//  Created by Murrali Ramasamy on 24/7/18.
//  Copyright © 2018 Murrali Ramasamy. All rights reserved.
//

import UIKit

class AskQuestionViewController: UIViewController {

    @IBOutlet weak var outCancelBn: UIBarButtonItem!
    @IBOutlet weak var outQnTextField: UITextView!
    @IBOutlet weak var switchMultiSel: UISwitch!
    @IBOutlet weak var outAddBn: UIButton!
    @IBOutlet weak var outAskBn: UIButton!
    @IBOutlet weak var outTableView: UITableView!
    
    
    @IBAction func actCancelBn(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func actAddBn(_ sender: UIButton) {
    }
    
    @IBAction func actAskBn(_ sender: UIButton) {
    }
    
    @IBAction func actDelOptBn(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension AskQuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "choiceCell", for: indexPath)
        
        cell.backgroundColor = .red
        
        return cell
    }
}
