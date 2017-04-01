//
//  CsvImporter.swift
//  OceanLife
//
//  Created by Paul Addy on 2016-10-29.
//  Copyright © 2016 Paul Addy. All rights reserved.
//

import Foundation

var data: [[String:String]] = []
var columnTitles: [String] = []

func convertCSV(file: String){
    let rows = cleanRows(file: file).components(separatedBy: "\n")
    print("------> rows.count: \(rows.count)")
    if rows.count > 0 {
        data = []
        //columnTitles = getStringFieldsForRow(row: rows.first!, delimiter: ",")
        columnTitles = getStringFieldsForRow(row: rows.first!, delimiter: "\t")
        for row in rows {
            print("------> row: \(row)")
            let fields = getStringFieldsForRow(row: row, delimiter: ",")
            if fields.count != columnTitles.count { continue }
            var dataRow = [String: String]()
            for (index, field) in fields.enumerated() {
                let fieldName = columnTitles[index]
                dataRow[fieldName] = field
                print("------> dataRow[fieldName]: \(dataRow[fieldName]!)")
            }
            print("------> dataRow: \(dataRow)")
            print(dataRow)
            data += [dataRow]
        }
    } else {
        print("No data in file")
    }
}

func getStringFieldsForRow(row: String, delimiter: String) -> [String] {
    return row.components(separatedBy: delimiter)
}

func printData(){
    convertCSV(file: "")
    var tableString = ""
    var rowString = ""
    print("data: \(data)")
    for row in data {
        rowString = ""
        for fieldName in columnTitles {
            guard let field = row[fieldName] else {
                print("field not found: \(fieldName)")
                continue
            }
            rowString += String(format: "%@     ", field)
        }
        tableString += rowString + "\n"
    }
    print(tableString)
}
func readDataFromFile(file: String) -> String! {
    guard let filePath = Bundle.main.path(forResource: file, ofType: "csv") else {
        return nil
    }
    print("-------> filePath: \(filePath)")
    
    do {
        let contents = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
        convertCSV(file: contents)
        return contents
    } catch {
        print("File read error for file \(file)")
        return nil
    }
}
func cleanRows(file: String) -> String {
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    return cleanFile
}

