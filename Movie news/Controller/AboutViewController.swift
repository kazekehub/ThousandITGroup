//
//  AboutViewController.swift
//  Movie news
//
//  Created by Beka Zhapparkulov on 9/20/20.
//  Copyright © 2020 Kazybek. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController, MFMailComposeViewControllerDelegate  {

    @IBOutlet weak var writeToEmail: UIButton!
    @IBOutlet weak var LinkendInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        writeToEmail.layer.cornerRadius = 10
        LinkendInButton.layer.cornerRadius = 10
    }
    
    @IBAction func wirteToEmail(_ sender: Any) {
         messageSend(email: "kzhapparkulov@gmail.com")
    }
    
    @IBAction func LinkedInButton(_ sender: Any) {
        guard let url = URL(string: "https://www.linkedin.com/in/kazybek-zhapparkulov/") else { return }
        UIApplication.shared.open(url)
    }
    
    func messageSend(email: String) {
        if MFMailComposeViewController.canSendMail() {
        let mymail = MFMailComposeViewController()
        mymail.mailComposeDelegate = self
        mymail.setToRecipients([email])
        present(mymail, animated: true)
        } else {
            print("Can not send email")
        }
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
}
