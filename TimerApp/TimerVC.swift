//
//  TimerVC.swift
//  TimerApp
//
//  Created by Roman on 2/27/16.
//  Copyright © 2016 Roman Puzey. All rights reserved.
//

import UIKit

class TimerVC: UIViewController
{
    var counter = 0
    var timer = NSTimer()
    var timerIsRunning = false
    var stopWasPressed = false
    var lastValue = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        timerLabel.text = "\(counter)"
        minutesLabel.text = "\(Int(minuteSlider.value)) min"
        secondsLabel.text = "\(Int(secondsSlider.value)) sec"
        // Do any additional setup after loading the view.
    }


    @IBAction func startButtonPressed(sender: AnyObject)
    {
        if timerIsRunning == false
        {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "updateTimer", userInfo: nil, repeats: true)

        if stopWasPressed
        {
            counter = lastValue
        }
        else
        {
            counter = counter + Int(secondsSlider.value) + (Int(minuteSlider.value)*60)
          }
        }
        stopWasPressed = false
        makeStartAppear(false)
        timerIsRunning = true
        timerLabel.backgroundColor = UIColor.whiteColor()
    }

    @IBOutlet weak var stopButton: UIButton!
    @IBAction func stopButtonAction(sender: AnyObject)
    {
        timerIsRunning = false
        timer.invalidate()
        makeStartAppear(true)
        stopWasPressed = true
        lastValue = counter
    }

    @IBOutlet weak var resetButton: UIButton!
    @IBAction func resetButtonAction(sender: AnyObject)
    {
        makeStartAppear(true)
        timerIsRunning = false
        counter = 0
        timer.invalidate()
        timerLabel.text = String(counter)
    }

    @IBOutlet weak var minuteSlider: UISlider!
        {
        didSet{
            minuteSlider.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        }
    }

    @IBAction func minuteSliderAction(sender: AnyObject)
    {
        minutesLabel.text = "\(Int(minuteSlider.value)) min"
    }

    @IBOutlet weak var secondsSlider: UISlider!
        {
        didSet{
            secondsSlider.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
        }
    }

    @IBOutlet weak var startButton: UIButton!


    func makeStartAppear(makeAppear: Bool)
    {
        if makeAppear
        {
            startButton.hidden = false
            resetButton.hidden = true
            stopButton.hidden = true
        }
        else
        {
            startButton.hidden = true
            resetButton.hidden = false
            stopButton.hidden = false
        }
    }

    @IBAction func secondsSliderAction(sender: AnyObject)
    {
        secondsLabel.text = "\(Int(secondsSlider.value)) sec"
    }

    

    func updateTimer()
    {
        counter = counter - 1
        timerLabel.text = "\(counter)"
        if counter < 0
        {
            counter = 0
            timerLabel.text = "Time is Up!!!!"
            timerLabel.backgroundColor = UIColor.redColor()
            timer.invalidate()
            stopWasPressed = false
            makeStartAppear(true)
            timerIsRunning = false
        }
    }

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
