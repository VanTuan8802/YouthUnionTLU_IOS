//
//  Student.swift
//  YouthUnionTLU
//
//  Created by VanTuan on 21/03/2024.
//

import Foundation

struct Address: Codable {
    let ward: String
    let district: String
    let city: String
}

struct PersionalInformation: Decodable {
    let name: String
    let avatarUrl: String
    let date_Of_Birth: String
    let gender: String
    let nation: String
    let religion: String
    let phoneNumber: String
    let citizentId: String
    let date_Of_Range: String
    let address_Of_Range: String
}

struct StudentInformation: Decodable {
    let className: String
    let batch: String
    let faculaty: String
    let major: String
    let email: String
    let year_Of_Admission: Int
    let year_Of_HighSchool_Graduation: Int
    let account_Number: String
    let bankName: String
}

struct ProfileStudent: Decodable {
    let persionalInformation: PersionalInformation
    let studentInformation: StudentInformation
}
