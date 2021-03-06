//
//  QuoteTableViewController.swift
//  InspoQuotes
//
//  Created by Angela Yu on 18/08/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import UIKit
import StoreKit

class QuoteTableViewController: UITableViewController, SKPaymentTransactionObserver {
    

    
    var quotesToShow = [
        "Our greatest glory is not in never falling, but in rising every time we fall. — Confucius",
        "All our dreams can come true, if we have the courage to pursue them. – Walt Disney",
        "It does not matter how slowly you go as long as you do not stop. – Confucius",
        "Everything you’ve ever wanted is on the other side of fear. — George Addair",
        "Success is not final, failure is not fatal: it is the courage to continue that counts. – Winston Churchill",
        "Hardships often prepare ordinary people for an extraordinary destiny. – C.S. Lewis"
    ]
    
    let premiumQuotes = [
        "Believe in yourself. You are braver than you think, more talented than you know, and capable of more than you imagine. ― Roy T. Bennett",
        "I learned that courage was not the absence of fear, but the triumph over it. The brave man is not he who does not feel afraid, but he who conquers that fear. – Nelson Mandela",
        "There is only one thing that makes a dream impossible to achieve: the fear of failure. ― Paulo Coelho",
        "It’s not whether you get knocked down. It’s whether you get up. – Vince Lombardi",
        "Your true success in life begins only when you make the commitment to become excellent at what you do. — Brian Tracy",
        "Believe in yourself, take on your challenges, dig deep within yourself to conquer fears. Never let anyone bring you down. You got to keep going. – Chantal Sutherland"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        isPurchased()
        SKPaymentQueue.default().add(self)
    }



    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return quotesToShow.count + 1
    }



    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellID, for: indexPath)
        if indexPath.row < quotesToShow.count {
            cell.textLabel?.text = quotesToShow[indexPath.row]
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .none
            return cell
        } else {
            let purchasedStatus = UserDefaults.standard.bool(forKey: K.productID)
            if purchasedStatus {
                return cell
            } else {
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.text = "Get more quotes!"
                cell.textLabel?.textColor = #colorLiteral(red: 0.03564627841, green: 0.5182372928, blue: 1, alpha: 1)
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        }
    }



    func showPremiumQotes() {
        quotesToShow.append(contentsOf: premiumQuotes)
        tableView.reloadData()
    }



    func isPurchased() {
        let purchasedStatus = UserDefaults.standard.bool(forKey: K.productID)
        if purchasedStatus {
            showPremiumQotes()
        }
    }



    //MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == quotesToShow.count {
            buyPremiumQuotes()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }



    //MARK: - In-app purchase methods
    @IBAction func restorePressed(_ sender: UIBarButtonItem) {
        
    }



    func buyPremiumQuotes() {
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = K.productID
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            print("User cannot make payments")
        }
    }



    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                UserDefaults.standard.set(true, forKey: K.productID)
                showPremiumQotes()
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .failed {
                if let error = transaction.error {
                    let error = error.localizedDescription
                    print("Failed with error: \(error)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }



}
