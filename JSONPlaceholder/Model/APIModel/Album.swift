//
//  Album.swift
//  JSONPlaceholder
//
//  Created by Wii Lin on 2020/11/4.
//

import Foundation


struct Album: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}
