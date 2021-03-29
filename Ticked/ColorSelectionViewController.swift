//
//  DrawerViewController.swift
//  Ticked
//
//  Created by Vincent Coetzee on 3/23/21.
//  Copyright © 2021 Vincent Coetzee. All rights reserved.
//

import UIKit

public protocol ColorSelectionDelegate
    {
    func didSelectColor(_ color:UIColor)
    }
    
class ColorSelectionViewController: UIViewController
    {
    @IBOutlet var label1:UILabel!
    @IBOutlet var label2:UILabel!
    @IBOutlet var label3:UILabel!
    @IBOutlet var label4:UILabel!
    @IBOutlet var label5:UILabel!
    @IBOutlet var cancelButton:UIButton!
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var view1:ColorClickView!
    @IBOutlet var view2:ColorClickView!
    @IBOutlet var view3:ColorClickView!
    @IBOutlet var view4:ColorClickView!
    @IBOutlet var view5:ColorClickView!
    
    public var delegate:ColorSelectionDelegate?
    private var selectedColor = UIColor.white
    
    override func viewDidLoad()
        {
        super.viewDidLoad()
        self.initViews()
        }
        
    private func initViews()
        {
        cancelButton.addTarget(self,action: #selector(onCancelTapped),for: UIControl.Event.primaryActionTriggered)
        self.view1.selectionColor = .tickedNeonGreen
        self.view1.action = #selector(onNeonGreenTapped)
        self.view1.target = self
        self.view2.selectionColor = .tickedNeonOrange
        self.view2.action = #selector(onNeonOrangeTapped)
        self.view2.target = self
        self.view3.selectionColor = .tickedNeonPink
        self.view3.action = #selector(onNeonPinkTapped)
        self.view3.target = self
        self.view4.selectionColor = .tickedNeonYellow
        self.view4.action = #selector(onNeonYellowTapped)
        self.view4.target = self
        self.view5.selectionColor = .tickedNeonRed
        self.view5.action = #selector(onNeonRedTapped)
        self.view5
        .target = self
        self.label1.text = "Neon Green"
        self.label1.textColor = .tickedNeonGreen
        self.label2.text = "Neon Orange"
        self.label2.textColor = .tickedNeonOrange
        self.label3.text = "Neon Pink"
        self.label3.textColor = .tickedNeonPink
        self.label4.text = "Neon Yellow"
        self.label4.textColor = .tickedNeonYellow
        self.label5.text = "Neon Red"
        self.label5.textColor = .tickedNeonRed
        }
        
    public override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator)
        {
        if let view = context.nextFocusedView as? ColorClickView
            {
            if view == self.view1
                {
                self.titleLabel.textColor = .tickedNeonGreen
                }
            else if view == self.view2
                {
                self.titleLabel.textColor = .tickedNeonOrange
                }
            else if view == self.view3
                {
                self.titleLabel.textColor = .tickedNeonPink
                }
            else if view == self.view4
                {
                self.titleLabel.textColor = .tickedNeonYellow
                }
            else if view == self.view5
                {
                self.titleLabel.textColor = .tickedNeonRed
                }
            else
                {
                self.titleLabel.textColor = .white
                }
            }
        }

    @IBAction func onNeonGreenTapped(_ sender:Any?)
        {
        self.selectedColor = .tickedNeonGreen
        self.delegate?.didSelectColor(self.selectedColor)
        self.dismiss(animated: true, completion: nil)
        }
        
    @IBAction func onNeonYellowTapped(_ sender:Any?)
        {
        self.selectedColor = .tickedNeonYellow
        self.delegate?.didSelectColor(self.selectedColor)
        self.dismiss(animated: true, completion: nil)
        }
        
    @IBAction func onNeonOrangeTapped(_ sender:Any?)
        {
        self.selectedColor = .tickedNeonOrange
        self.delegate?.didSelectColor(self.selectedColor)
        self.dismiss(animated: true, completion: nil)
        }
    
    @IBAction func onNeonRedTapped(_ sender:Any?)
        {
        self.selectedColor = .tickedNeonRed
        self.delegate?.didSelectColor(self.selectedColor)
        self.dismiss(animated: true, completion: nil)
        }
        
    @IBAction func onNeonPinkTapped(_ sender:Any?)
        {
        self.selectedColor = .tickedNeonPink
        self.delegate?.didSelectColor(self.selectedColor)
        self.dismiss(animated: true, completion: nil)
        }
        
    @IBAction func onCancelTapped(_ sender:Any?)
        {
        self.dismiss(animated: true, completion: nil)
        }
    }
