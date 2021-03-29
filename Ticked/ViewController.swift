//
//  ViewController.swift
//  Ticked
//
//  Created by Vincent Coetzee on 2018/08/09.
//  Copyright © 2018 Vincent Coetzee. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ColorSelectionDelegate
    {
    private static let kStateColorKey = "TextColor"
    
    @IBOutlet var hour1:DigitView!
    @IBOutlet var hour2:DigitView!
    @IBOutlet var minute1:DigitView!
    @IBOutlet var minute2:DigitView!
    @IBOutlet var second1:DigitView!
    @IBOutlet var second2:DigitView!
    @IBOutlet var colon1:UILabel!
    @IBOutlet var colon2:UILabel!
    @IBOutlet var date:UILabel!
    @IBOutlet var drawerView:UIView!
    
    private var timer:DispatchSourceTimer?
    private var textColor:UIColor = UIColor.tickedNeonOrange
    
    override func viewDidLoad()
        {
        super.viewDidLoad()
        self.initTimer()
        self.loadSavedState()
        self.configureColors()
        self.initGestureRecognizer()
        }

    private func loadSavedState()
        {
        let defaults = UserDefaults.standard
        if let values = defaults.object(forKey: Self.kStateColorKey) as? Array<CGFloat>
            {
            self.textColor = UIColor(valueArray:values)
            }
        }
        
    private func saveState()
        {
        let defaults = UserDefaults.standard
        defaults.set(self.textColor.valueArray,forKey: Self.kStateColorKey)
        }
        
    private func configureColors()
        {
        self.colon1.textColor = self.textColor
        self.colon2.textColor = self.textColor
        self.date.textColor = self.textColor
        self.hour1.textColor = self.textColor
        self.hour2.textColor = self.textColor
        self.minute1.textColor = self.textColor
        self.minute2.textColor = self.textColor
        self.second1.textColor = self.textColor
        self.second2.textColor = self.textColor
        }
        
    private func initGestureRecognizer()
        {
        let recognizer = UISwipeGestureRecognizer(target:self,action:#selector(onSwipeUp))
        recognizer.direction = .up
        self.view.addGestureRecognizer(recognizer)
        }
        
    @IBAction func onSwipeUp(_ sender:Any?)
        {
        let controller = ColorSelectionViewController(nibName: "ColorSelectionViewController", bundle: nil)
        controller.modalPresentationStyle = .custom
        let viewSize = controller.view.frame.size
        controller.preferredContentSize = CGSize(width:500,height:200)
        controller.view.backgroundColor = UIColor.black
        controller.view.bounds = CGRect(origin:.zero,size:viewSize)
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
        }
        
    public func didSelectColor(_ color:UIColor)
        {
        self.textColor = color
        self.saveState()
        self.configureColors()
        }
        
    private func initTimer()
        {
        timer = DispatchSource.makeTimerSource(queue: .main)
        timer?.schedule(deadline: DispatchTime.now(),repeating: .seconds(1),leeway: .milliseconds(500))
        timer?.setEventHandler
            {
            let digits = self.timeDigits()
            DispatchQueue.main.async
                {
                self.hour1.digit = digits[0]
                self.hour2.digit = digits[1]
                self.minute1.digit = digits[2]
                self.minute2.digit = digits[3]
                self.second1.digit = digits[4]
                self.second2.digit = digits[5]
                }
            }
        timer?.resume()
        }
    
    private func timeDigits() -> [String]
        {
        let dateComponents = Calendar.current.dateComponents([.hour,.minute,.second,.day,.month,.year,.weekday], from: Date())
        let hours = dateComponents.hour!
        let minutes = dateComponents.minute!
        let seconds = dateComponents.second!
        let hourUpper = hours / 10
        let hourLower = hours - hourUpper * 10
        let minuteUpper = minutes / 10
        let minuteLower = minutes - minuteUpper * 10
        let secondUpper = seconds / 10
        let secondLower = seconds - secondUpper * 10
        let strings = ["\(hourUpper)","\(hourLower)","\(minuteUpper)","\(minuteLower)","\(secondUpper)","\(secondLower)"]
        let dayOfWeekIndex = (dateComponents.weekday! - 1) % 7
        let dayOfWeek = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"][dayOfWeekIndex]
        let monthIndex = (dateComponents.month! - 1) % 12
        let monthName = ["January","February","March","April","May","June","July","August","September","October","November","December"][monthIndex]
        let dateString = "\(dayOfWeek) \(dateComponents.day!) \(monthName) \(dateComponents.year!)"
        self.date.text = dateString
        return(strings)
        }
    }

