//
//  PickupDetailViewController.swift
//  EcoSoapBank
//
//  Created by Jon Bash on 2020-08-19.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit
import SwiftUI


class PickupDetailViewController: UIViewController {
    
//    @IBOutlet private var tableView: UITableView!
//    @IBOutlet private var headingLabels: [UILabel]!
    
//    @IBOutlet private weak var confirmationCodeLabel: UILabel!
//    @IBOutlet private weak var statusLabel: UILabel!
//    @IBOutlet private weak var readyDateLabel: UILabel!
//    @IBOutlet private weak var pickupDateLabel: UILabel!
//    @IBOutlet private weak var cartonStack: UIStackView!
//    @IBOutlet private weak var notesView: UITextView!

    private var cartonViewCache: [UIStackView] = []
    
    private var cells: [(text: String, detail: String)] {
        [
            ("Confirmation Code", pickup.confirmationCode),
            ("Status", pickup.status.display),
            ("Ready Date", pickup.readyDate.string()),
            ("Pickup Date", pickup.pickupDate?.string() ?? "N/A"),
        ]
    }
    
    var pickup: Pickup {
        didSet {
            guard isViewLoaded else { return }
            setUpViews()
        }
    }
    
    // MARK: - Init / Lifecycle
    
    init?(coder: NSCoder, pickup: Pickup) {
        self.pickup = pickup
        super.init(coder: coder)
    }
    
    @available(*, unavailable, message: "Use init(coder:pickup:)")
    required init?(coder: NSCoder) {
        fatalError("Use `init(coder:pickup:)`")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        
//        tableView.dataSource = self
        // set fonts
        //        [confirmationCodeLabel, statusLabel, readyDateLabel, pickupDateLabel]
        //            .forEach { $0.font = .muli(style: .body) }
//        headingLabels.forEach { $0.font = .muli(style: .body, typeface: .bold) }
//        notesView.font = UIFont.muli(ofSize: 13)
        // swiftlint:disable line_length
//        notesView.text = """
//        Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda.
//        """
//        title = "Pickup Details"
//        notesView.textColor = UIColor.codGrey.orInverse()
    }
    
}

// MARK: - Private Helpers

extension PickupDetailViewController {
    private func setUpViews() {
        // set content from pickup
//        confirmationCodeLabel.text = pickup.confirmationCode
//        statusLabel.text = pickup.status.display
//        statusLabel.textColor = pickup.status.color
//        readyDateLabel.text = pickup.readyDate.string()
//        pickupDateLabel.text = pickup.pickupDate?.string() ?? ""
//        notesView.text = pickup.notes

//        // replace carton views
//        cartonStack.arrangedSubviews.forEach {
//            guard let cartonView = $0 as? UIStackView else { return }
//            cartonViewCache.append(cartonView)
//            cartonStack.removeArrangedSubview(cartonView)
//        }
//        pickup.cartons
//            .map(configuredViewForCarton(_:))
//            .forEach(cartonStack.addArrangedSubview(_:))
    }

//    private func configuredViewForCarton(_ carton: Pickup.Carton) -> UIView {
//        let cartonView = cartonViewCache.popLast() ?? newEmptyCartonView()
//
//        (cartonView.arrangedSubviews[0] as? UILabel)?.text =
//            carton.contents?.product.rawValue.capitalized ?? "<empty>"
//
//        (cartonView.arrangedSubviews[1] as? UILabel)?.text =
//            carton.contents?.percentFull.percentString ?? ""
//
//        return cartonView
//    }

//    private func newEmptyCartonView() -> UIStackView {
//        let labels = configure([UILabel(), UILabel()]) { labels in
//            labels.forEach { $0.font = .muli(style: .caption1) }
//            labels[0].textAlignment = .right
//        }
//        return configure(UIStackView(arrangedSubviews: labels)) {
//            $0.axis = .horizontal
//            $0.alignment = .fill
//            $0.distribution = .fillEqually
//            $0.spacing = 8
//        }
//    }
    
    
}

extension PickupDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickupDetailCell", for: indexPath)
        
        cell.textLabel?.text = cells[indexPath.row].text
        cell.textLabel?.font = .muli(style: .body, typeface: .bold)
        cell.detailTextLabel?.text = cells[indexPath.row].detail
        cell.detailTextLabel?.font = .muli(style: .callout, typeface: .regular)
        cell.detailTextLabel?.textColor = UIColor.codGrey.orInverse()
        return cell
    }
}

extension PickupDetailViewController {
    private struct _Representable: UIViewControllerRepresentable {
        let pickup: Pickup

        func makeUIViewController(context: Context) -> PickupDetailViewController {
            PickupDetailViewController.fromStoryboard { coder in
                PickupDetailViewController(coder: coder, pickup: self.pickup)
            }!
        }

        func updateUIViewController(
            _ uiViewController: PickupDetailViewController,
            context: Context
        ) {
            uiViewController.pickup = pickup
        }
    }

    struct Representable: View {
        let pickup: Pickup

        var body: some View {
            _Representable(pickup: pickup)
                .navigationBarTitle("Pickup Details")
        }
    }
}
