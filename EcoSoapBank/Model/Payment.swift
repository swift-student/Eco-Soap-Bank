//
//  Payment.swift
//  EcoSoapBank
//
//  Created by Christopher Devito on 8/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation

struct Payment: Decodable {
    let id: String
    let invoiceCode: String?
    let invoice: String?
    let amountPaid: String
    let amountDue: String
    let date: Date
    let invoicePeriodStartDate: Date?
    let invoicePeriodEndDate: Date?
    let dueDate: Date?
    let paymentMethod: PaymentMethod
}

struct PaymentInput: Encodable {
    let amountPaid: Int
    let date: Date
    let paymentMethod: PaymentMethod
    let hospitalityContractId: String
}

enum PaymentMethod: String, Codable {
    case ach = "ACH"
    case credit = "CREDIT"
    case debit = "DEBIT"
    case wire = "WIRE"
    case other = "OTHER"
}