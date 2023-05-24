//
//  ViewController.swift
//  OTPView
//
//  Created by mac on 25/12/22.
//

import UIKit

class longcell: UICollectionViewCell {

}

class ViewController: UIViewController {

    @IBOutlet weak var longtable: UITableView!
    @IBOutlet weak var longcollection: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func open(_ sender: UIButton) {
        if #available(iOS 14.0, *) {
            sender.menu = self.getContextMenu(data: "Copy this data")
            sender.showsMenuAsPrimaryAction = true
        } else {
            // Fallback on earlier versions
        }
    }

    @IBAction func openOnLong(_ sender: UIButton) {
        if #available(iOS 14.0, *) {
            sender.menu = self.getContextMenu(data: "Copy this data")
        } else {
            // Fallback on earlier versions
        }
    }

    @IBAction func longpressaction(_ sender: UIButton) {
        let interaction = UIContextMenuInteraction(delegate: self)
        sender.addInteraction(interaction)
    }

}

extension ViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "oyy Edhr click kro, Suno jra long press krna 😂😂😂😂 "

        let interaction = UIContextMenuInteraction(delegate: self)
        cell.contentView.tag = indexPath.item
        cell.contentView.superview?.tag = indexPath.section
        cell.contentView.addInteraction(interaction)

        return cell
    }

} // teamwork

extension ViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = longcollection.dequeueReusableCell(withReuseIdentifier: "longcell", for: indexPath) as! longcell
        let interaction = UIContextMenuInteraction(delegate: self)
        cell.contentView.tag = indexPath.item
        cell.contentView.superview?.tag = indexPath.section
        cell.contentView.addInteraction(interaction)
        return cell
    }

}

// MARk: - Context Menu & Action Sheet

extension ViewController: UIContextMenuInteractionDelegate {

    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//        guard _ == interaction.view?.superview?.tag, let _ = interaction.view?.tag else { return nil }
        return UIContextMenuConfiguration(identifier: "anyIdentifier" as NSCopying, previewProvider: nil, actionProvider: { _ in
            let contextMenu = self.getContextMenu(data: "Copy this data")
            return UIMenu(title: "", children: [contextMenu])
        })
    }

    func getContextMenu(data: String) -> UIMenu {
        let systemIcon = UIImage(systemName: "square.and.arrow.up.circle.fill")
        let customICon = UIImage(named: "bin (5)")

        let copyAction = UIAction(title: "Copy", image: systemIcon) { _ in
            UIPasteboard.general.string = data
        }

        let editImageAction = UIAction(title: "Edit", image: customICon) { _ in
            // Edit message
        }

        let infoAction = UIAction(title: "Info", image: customICon, attributes: .destructive) { _ in
            // write info code here.
        }

        let replyAction = UIAction(title: "Reply", image: systemIcon, attributes: .hidden) { _ in
            // Write reply code here.
        }

        let deleteAction = UIAction(title: "Delete", image: systemIcon, attributes: .disabled) { _ in
            // Delete message goes here
        }

        return UIMenu(title: "", options: .displayInline, children: [copyAction, editImageAction, infoAction, replyAction, deleteAction])
    }

}
