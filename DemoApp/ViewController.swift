//
//  ViewController.swift
//  DemoApp
//
//  Created by shyank on 29/04/24.
//

import UIKit
import MIPS_iOS_SDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makePayment()
    }
    
    private func makePayment() {
        self.view.backgroundColor = .red
        
        
    }
}

