//
//  RandomModel.swift
//  RandomuserMVVM
//
//  Created by kiras on 2020/5/17.
//  Copyright © 2020 ameyo. All rights reserved.
//

import Foundation

struct Base : Codable {
    let results : [Results]?
    let info : Info?

    enum CodingKeys: String, CodingKey {

        case results = "results"
        case info = "info"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([Results].self, forKey: .results)
        info = try values.decodeIfPresent(Info.self, forKey: .info)
    }
}

struct Results : Codable {
    let gender : String?
    let name : Name?
    let email : String?
    let phone : String?
    let cell : String?
    let picture : Picture?
    let nat : String?

    enum CodingKeys: String, CodingKey {

        case gender = "gender"
        case name = "name"
        case email = "email"
        case phone = "phone"
        case cell = "cell"
        case picture = "picture"
        case nat = "nat"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        name = try values.decodeIfPresent(Name.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        cell = try values.decodeIfPresent(String.self, forKey: .cell)
        picture = try values.decodeIfPresent(Picture.self, forKey: .picture)
        nat = try values.decodeIfPresent(String.self, forKey: .nat)
    }

}

struct Picture : Codable {
    let large : String?
    let medium : String?
    let thumbnail : String?

    enum CodingKeys: String, CodingKey {

        case large = "large"
        case medium = "medium"
        case thumbnail = "thumbnail"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        large = try values.decodeIfPresent(String.self, forKey: .large)
        medium = try values.decodeIfPresent(String.self, forKey: .medium)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
    }

}

struct Name : Codable {
    let title : String?
    let first : String?
    let last : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case first = "first"
        case last = "last"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        first = try values.decodeIfPresent(String.self, forKey: .first)
        last = try values.decodeIfPresent(String.self, forKey: .last)
    }

}


struct Info : Codable {
    let seed : String?
    let results : Int?
    let page : Int?
    let version : String?

    enum CodingKeys: String, CodingKey {

        case seed = "seed"
        case results = "results"
        case page = "page"
        case version = "version"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        seed = try values.decodeIfPresent(String.self, forKey: .seed)
        results = try values.decodeIfPresent(Int.self, forKey: .results)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        version = try values.decodeIfPresent(String.self, forKey: .version)
    }

}
