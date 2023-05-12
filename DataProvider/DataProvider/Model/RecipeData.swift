//
//  RecipeData.swift
//  DataProvider
//
//  Created by İbrahim Kültepe on 11.05.2023.
//

public struct RecipeData<T: Decodable>: Decodable {
    public let data: T
}
