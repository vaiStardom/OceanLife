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
        columnTitles = getStringFieldsForRow(row: rows.first!, delimiter: "\t")
        for row in rows {
            let fields = getStringFieldsForRow(row: row, delimiter: "\t")
            if fields.count != columnTitles.count {
                print("------> IMPORT ERROR: fields.count= \(fields.count), columnTitles.count= \(columnTitles.count)")
                print("------> ENTRY: \(fields)")
                continue
            }
            let specie = OceanLifeSpecies(
                imageNames: getStringFieldsForRow(row: fields[CsvFields.imageName.rawValue], delimiter: "/")
                , name: fields[CsvFields.name.rawValue]
                , nameLatin: fields[CsvFields.nameLatin.rawValue]
                , parentFamily: (fields[CsvFields.parentFamily.rawValue].isEmpty == true ? nil : fields[CsvFields.parentFamily.rawValue])
                , description: fields[CsvFields.description.rawValue]
            )
            SPECIES.append(specie)
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
        print("-------> FILE READ ERROR: file \(file) not read.")
        return nil
    }
    do {
        let contents = try String(contentsOfFile: filePath, encoding: String.Encoding.macOSRoman)
        convertCSV(file: contents)
        return contents
    } catch {
        print("File read error for file \(file). Error: \(error)")
        return nil
    }
}
func cleanRows(file: String) -> String {
    var cleanFile = file
    cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
    cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
    return cleanFile
}

