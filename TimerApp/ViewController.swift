//
//  ViewController.swift
//  TimerApp
//
//  Created by Roman on 2/27/16.
//  Copyright © 2016 Roman Puzey. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var counter = 1
    var startTime = NSTimeInterval()
    var timer: NSTimer = NSTimer()
    var timeArray: NSMutableArray = NSMutableArray()

    @IBOutlet weak var stopButton: UIButton!
    @IBAction func stopButtonAction(sender: AnyObject)
    {
        makeStartAppear(true)
        timer.invalidate()
    }

    @IBOutlet weak var tableView: UITableView!


    @IBOutlet weak var resetButton: UIButton!
    @IBAction func resetButtonAction(sender: AnyObject)
    {
        // makeStartAppear(true)
        timeArray.addObject("\(counter) -> " + stopWatchTime.text!)
        counter++
        tableView.reloadData()
    }

    @IBOutlet weak var startButton: UIButton!
    @IBAction func startButtonAction(sender: AnyObject)
    {
        makeStartAppear(false)
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: "updateTime", userInfo: nil, repeats: true)
        startTime = NSDate.timeIntervalSinceReferenceDate()
        timeArray.removeAllObjects()
        tableView.reloadData()
        counter = 1
    }

    @IBOutlet weak var stopWatchTime: UILabel!


    func updateTime()
    {
        let currenTime = NSDate.timeIntervalSinceReferenceDate()
        var elapsedTime : NSTimeInterval = currenTime - startTime

        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (NSTimeInterval(minutes)*60)

        let seconds = UInt8(elapsedTime)
        elapsedTime -= NSTimeInterval(seconds)

        let fraction = UInt8(elapsedTime * 100)

        let strMinutes = minutes > 9 ? String(minutes):"0" + String(minutes)
        let strSeconds = seconds > 9 ? String(seconds):"0" + String(seconds)
        let strFraction = fraction > 9 ? String(fraction):"0" + String(fraction)

        stopWatchTime.text = "\(strMinutes):\(strSeconds):\(strFraction)"
    }

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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.timeArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        let cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")!

        cell.textLabel!.text = self.timeArray.objectAtIndex(indexPath.row) as? String

        return cell

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}