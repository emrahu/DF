//
//  EventsViewController.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import UIKit

class EventsTableViewController: UITableViewController {
    
    let NetworkReachabilityChanged = NSNotification.Name("NetworkReachabilityChanged")
    var viewModel: EventsTableViewModel!{
        didSet {
            title = viewModel?.title
        }
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        checkConnection()
        viewModel = EventsTableViewModel()
        _setViewComponents()
    }
    
    func checkConnection(){
        NotificationCenter.default.addObserver(forName: NetworkReachabilityChanged, object: nil, queue: nil, using: {
            (notification) in
            if let userInfo = notification.userInfo {
                let isThereConnection = userInfo["reachabilityStatus"] as! Bool
                
                if !isThereConnection {
                    self.title = "No internet connection - \(self.viewModel.title)"
                    self.displayAlert(vc: self, title: "No internet", message: "There is no internet connection")
                } else {
                    self.loadEvents()
                }
            }
        })
    }
    
    func loadEvents(){
        let loadingSpinner = UIViewController.displaySpinner(onView: self.view)
        title = "\(viewModel.title) loading..."
        viewModel.events { [weak self] (success, error) in
            UIViewController.removeSpinner(spinner: loadingSpinner)
            self?.title = self?.viewModel.title
            if success {
                self?.tableView.reloadData()
            } else {
                
                let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                let okAction = UIAlertAction(title: "Try Again", style: .default, handler: { (action) in
                    self?.loadEvents()
                    self?.view.setNeedsDisplay()
                    self?.view.needsUpdateConstraints()
                    self?.view.setNeedsLayout()
                })
                
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    fileprivate func _setViewComponents(){
        tableView.estimatedRowHeight = 100
        tableView.register(EventTableViewCell.self, forCellReuseIdentifier: self.viewModel.eventCellIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel!.events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.eventCellIdentifier, for: indexPath) as! EventTableViewCell
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        guard let event = viewModel?.events[indexPath.row] else { return UITableViewCell() }
        
        cell.labelName.text = event.name!.uppercased()
        cell.labelDescription.text = "\(event.description!)\n\(event.location!.toString()!)"
        
        let eventId = event.id
        var imageId = ""
        if event.images!.count > 0 {
            imageId = event.images!.first!.id!
            DispatchQueue.global(qos: .background).async {
                self.viewModel.eventImage(eventId: eventId!, imageId: imageId, completionHandler: { (image) in
                    DispatchQueue.main.async {
                        cell.imageViewThumb.image = image
                        cell.imageViewThumb.backgroundColor = UIColor.groupTableViewBackground
                    }
                })
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCellIndexPath = tableView.indexPathForSelectedRow!
        let event = viewModel.events[selectedCellIndexPath.row]
        let eventDetailsViewController = EventDetailsViewController()
        eventDetailsViewController.viewModel = EventDetailsViewModel(event: event)
        let eventGoing = eventDetailsViewController.viewModel.getEvent()
        if eventGoing != nil {
            eventDetailsViewController.viewModel.eventState = .attending
        } else {
           eventDetailsViewController.viewModel.eventState = .notAttending
        }
        self.navigationController?.pushViewController(eventDetailsViewController, animated: true)
    }
}

