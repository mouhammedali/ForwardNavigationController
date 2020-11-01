//
//  ViewController.swift
//  ForwardNavigationController
//
//  Created by mouhammedali on 10/31/2020.
//  Copyright (c) 2020 mouhammedali. All rights reserved.
//

import UIKit
import ForwardNavigationController
class ViewController: UIViewController {
    var vcNumber = 1
    @IBOutlet private weak var numberLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        (self.navigationController as? ForwardNavigationController)?.allowForward = false
//        (self.navigationController as? ForwardNavigationController)
    }
    
    @IBAction func pushPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.vcNumber = vcNumber + 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        numberLabel.text = "\(vcNumber)"
        let randomColor: UIColor = .random
        view.backgroundColor = randomColor
        numberLabel.textColor = randomColor.complement
    }
}
