//
//  LocationDetailsViewController.swift
//  MyLocations
//
//  Created by Dan Patey on 5/5/16.
//  Copyright © 2016 Dan Patey. All rights reserved.
//

import UIKit
import CoreLocation

private let dateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateStyle = .MediumStyle
    formatter.timeStyle = .ShortStyle
    return formatter
}()

class LocationDetailViewController: UITableViewController {
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var categoryName = "Category Name"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = ""
        categoryLabel.text = categoryName
        
        latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
        longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
        
        if let placemark = placemark {
            addressLabel.text = stringFromPlacemark(placemark)
        } else {
            addressLabel.text = "No Address Found"
        }
        
        dateLabel.text = formatDate(NSDate())
    }
    
    func stringFromPlacemark(placemark: CLPlacemark) -> String {
        var text = ""
        
        if let s = placemark.subThoroughfare {
            text += s + " "
        }
        if let s = placemark.thoroughfare {
            text += s + ", "
        }
        if let s = placemark.locality {
            text += s + ", "
        }
        if let s = placemark.administrativeArea {
            text += s + " "
        }
        if let s = placemark.postalCode {
            text += s + ", "
        }
        if let s = placemark.country {
            text += s
        }
        return text
    }
    
    func formatDate(date: NSDate) -> String {
        return dateFormatter.stringFromDate(date)
    }
    
    @IBAction func done() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var placemark: CLPlacemark?
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 88
        } else if indexPath.section == 2 && indexPath.row == 2 {
            addressLabel.frame.size = CGSize(width: view.bounds.size.width - 115, height: 10000)
            addressLabel.sizeToFit()
            addressLabel.frame.origin.x = view.bounds.size.width - addressLabel.frame.size.width - 15
            
            return addressLabel.frame.size.height + 20
        
        } else {
            return 44
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PickCategory" {
            let controller = segue.destinationViewController as! CategoryPickerViewController
            controller.selectedCategoryname = categoryName
        }
    }
}