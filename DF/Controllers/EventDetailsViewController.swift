//
//  EventDetailsViewController.swift
//  DragonFly
//
//  Created by Emrah Usar on 3/8/18.
//  Copyright © 2018 Usar Labs. All rights reserved.
//

import UIKit
import MessageUI

class EventDetailsViewController: UIViewController {
    
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    var collectionViewImages:UICollectionView!
    var labelDate:UILabel!
    var labelAddress:UILabel!
    var labelGoing: UILabel!
    var switchGoing: UISwitch!
    var labelDescription:UILabel!
    var buttonComments:UIButton!
    
    var constraintDescriptionBottom: NSLayoutConstraint!
    var constraintContenViewHeight: NSLayoutConstraint!
    var tableViewComments: UITableView!
    
    var viewModel: EventDetailsViewModel! {
        didSet {
            title = viewModel.event.name?.uppercased()
        }
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        
        _setViewComponents()
        _setViewConstraints()
        
        
        self.labelDate.text = viewModel.eventDate!
        self.labelAddress.text = viewModel.event.location?.toString()
        self.labelGoing.text = EventDetailsViewModel.EventState.notAttending.rawValue
        self.labelDescription.text = viewModel.event.description
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapShare))
        
        switch viewModel.eventState! {
        case .attending:
            self.switchGoing.isOn = true
            self.labelGoing.text = viewModel.eventState.rawValue
        default:break
        }
    }
    
    
    fileprivate func _setViewComponents(){
        scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        
        contentView = UIView()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.size.width, height: 10)
        collectionViewImages = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionViewImages.register(EventGalleryCollectionViewCell.self, forCellWithReuseIdentifier: EventGalleryCollectionViewCell.cellIdentifier)
        collectionViewImages.delegate = self
        collectionViewImages.dataSource = self
        
        labelDate = UILabel()
        labelDate.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        labelDate.textColor = .black
        
        labelAddress = UILabel()
        labelAddress.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        labelAddress.textColor = .black
        labelAddress.numberOfLines = 0
        
        labelGoing = UILabel()
        labelGoing.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
        labelGoing.textColor = .black
        
        switchGoing = UISwitch()
        switchGoing.addTarget(self, action: #selector(didTapSwitch(_:)), for: .touchUpInside)
        
        labelDescription = UILabel()
        labelDescription.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        labelDescription.textColor = .gray
        labelDescription.numberOfLines = 0
        
        tableViewComments = UITableView(frame: CGRect(), style: .plain)
        tableViewComments.register(CommentTableViewCell.self, forCellReuseIdentifier: viewModel.commentCellIdentifier)
        tableViewComments.tableFooterView = UIView()
        tableViewComments.delegate = self
        tableViewComments.dataSource = self
        
        contentView.addSubview(collectionViewImages)
        contentView.addSubview(labelDate)
        contentView.addSubview(labelAddress)
        contentView.addSubview(labelGoing)
        contentView.addSubview(switchGoing)
        contentView.addSubview(labelDescription)
        contentView.addSubview(tableViewComments)
        
        scrollView.addSubview(contentView)
        view.addSubview(scrollView)
        
    }
    fileprivate func _setViewConstraints(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        scrollView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0).isActive = true
        scrollView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 0).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        constraintContenViewHeight  = contentView.heightAnchor.constraint(equalTo: view.heightAnchor)
        constraintContenViewHeight.constant = 300
        constraintContenViewHeight.isActive = true
        contentView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        
        collectionViewImages.translatesAutoresizingMaskIntoConstraints = false
        collectionViewImages.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0).isActive = true
        collectionViewImages.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        collectionViewImages.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0).isActive = true
        collectionViewImages.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        labelDate.translatesAutoresizingMaskIntoConstraints = false
        labelDate.heightAnchor.constraint(equalToConstant: 30).isActive = true
        labelDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        labelDate.topAnchor.constraint(equalTo: collectionViewImages.bottomAnchor, constant: 10).isActive = true
        
        
        labelGoing.translatesAutoresizingMaskIntoConstraints = false
        labelGoing.topAnchor.constraint(equalTo: collectionViewImages.bottomAnchor, constant: 10).isActive = true
        labelGoing.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        switchGoing.translatesAutoresizingMaskIntoConstraints = false
        switchGoing.topAnchor.constraint(equalTo: labelGoing.bottomAnchor, constant: 10).isActive = true
        switchGoing.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        labelAddress.translatesAutoresizingMaskIntoConstraints = false
        labelAddress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        labelAddress.topAnchor.constraint(equalTo: labelDate.bottomAnchor, constant: 5).isActive = true
        labelAddress.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        labelDescription.translatesAutoresizingMaskIntoConstraints = false
        labelDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        labelDescription.topAnchor.constraint(equalTo: labelAddress.bottomAnchor, constant: 5).isActive = true
        labelDescription.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        
        tableViewComments.translatesAutoresizingMaskIntoConstraints = false
        tableViewComments.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 10).isActive = true
        tableViewComments.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableViewComments.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableViewComments.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        tableViewComments.setContentHuggingPriority(.defaultLow, for: .vertical)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        if UIDevice.current.orientation.isLandscape {
            constraintContenViewHeight.constant = 300
        } else {
            constraintContenViewHeight.constant = 300
        }
    }
    
    
    
    
    @objc func didTapSwitch(_ sender:UISwitch){
        let switchState = sender.isOn
        
        DispatchQueue.global(qos: .background).async {
            self.viewModel.attendEvent(attend: switchState, completionHandler: { (success, error) in
                DispatchQueue.main.async {
                    if success {
                        if switchState {
                            // If request and switch state are true then attend the event
                            self.viewModel.eventState = .attending
                            self.labelGoing.text = self.viewModel.eventState.rawValue

                        } else {
                            // If request is true and switch state turned false then do not attend the event
                            self.switchGoing.isOn = false
                            self.viewModel.eventState = .notAttending
                            self.labelGoing.text =  self.viewModel.eventState.rawValue
                        }
                        self.viewModel.updateEvent() // Update event
                    } else {
                        if switchState {
                            // If request is false, switch state turned true then do not attend the event
                            self.switchGoing.isOn = false
                            self.viewModel.eventState = .notAttending
                            self.labelGoing.text =  self.viewModel.eventState.rawValue
                            
                        } else {
                            // If request is false, switch state turned false then do not attend the event
                            self.viewModel.eventState = .attending
                            self.labelGoing.text = self.viewModel.eventState.rawValue
                            self.switchGoing.isOn = true
                        }
                        self.displayAlert(vc: self, title: "", message: error!)
                    }
                }
            })
        }
    }
    
    
    
    @objc func didTapShare(){
        if !MFMailComposeViewController.canSendMail() {

            displayAlert(vc: self, title:"Error", message:"Mail services are not available")
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setSubject("\(viewModel.event.name!)")
        
        if let imageData = viewModel.imageToShare {
            guard let image: Data = UIImagePNGRepresentation(imageData) else {
                
                self.displayAlert(vc: self, title: "", message: "No image loaded. Please try again")
                return
            }
            composeVC.addAttachmentData(image, mimeType: "image/png", fileName: "image")
        }
        composeVC.setMessageBody(viewModel.emailBody!, isHTML: true)
        self.present(composeVC, animated: true, completion: nil)
    }
}

extension EventDetailsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.event.images!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewImages.dequeueReusableCell(withReuseIdentifier: EventGalleryCollectionViewCell.cellIdentifier, for: indexPath) as! EventGalleryCollectionViewCell
        guard let images = viewModel.event.images else {
            return UICollectionViewCell()
        }
        
        let image = images[indexPath.row]
        
        DispatchQueue.global(qos: .background).async {
            self.viewModel.eventImage(eventId: self.viewModel.event.id!, imageId: image.id!) { (image) in
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            }
        }
        cell.labelCaption.text = image.caption!
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 230)
    }
}

extension EventDetailsViewController: UITableViewDelegate {
    
}
extension EventDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = CellHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 56))
        headerview.labelHeader.text = viewModel.sectionHeader
        return headerview
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.event.comments!.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.commentCellIdentifier, for: indexPath) as! CommentTableViewCell
        let comment = viewModel.event!.comments![indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "\(comment.text!)\n\(comment.from!)"
        return cell
    }
}

extension EventDetailsViewController: MFMailComposeViewControllerDelegate{
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

class CellHeaderView: UIView {
    
    var labelHeader: UILabel!
    var textSize: CGFloat = 13
    var textColor: UIColor = .lightGray
    var weight: UIFont.Weight = .regular
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        _setViewComponents()
        _setConstraints()
    }
    
    private func _setViewComponents(){
        labelHeader = UILabel()
        labelHeader.sizeToFit()
        labelHeader.textColor = textColor
        labelHeader.font = UIFont.systemFont(ofSize: textSize, weight: UIFont.Weight.regular)
        addSubview(labelHeader)
    }
    private func _setConstraints(){
        labelHeader.translatesAutoresizingMaskIntoConstraints = false
        labelHeader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        labelHeader.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Initialization error")
    }
    
}


