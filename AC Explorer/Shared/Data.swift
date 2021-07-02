//
//  Data.swift[
//  AC
//
//  Created by Jared Pendergraft on 6/11/21.
//

import SwiftUI


// Models

struct Villager: Codable, Identifiable {
    var birthday_month, birthday_day, id, image_url, name, title_color, text_color, quote: String
    var nh_details: NHDetails
}

struct NHDetails: Codable {
    let clothing, clothing_variation, house_exterior_url, house_wallpaper, house_flooring : String
}

struct Animal: Codable, Hashable {
    var name, render_url, time: String
    var location: String? = ""
    var catchphrases: [String]
}

struct Variations: Codable, Hashable {
    var name, category: String
    var variations: [VariationSingle]
}

struct VariationSingle: Codable, Hashable {
    var variation, image_url: String
}

struct Item: Codable, Hashable {
    var name, category, image_url: String
}

struct Query: Codable {
    var label, query: String
}


struct QueryResultItem: Codable, Hashable {
    var label: String
    var response: Item
}

struct QueryResultVariations: Codable, Hashable {
    var label: String
    var response: Variations
}

// API queries

class Api {
    func getBirthday(day: String, month: String, completion: @escaping (Villager) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nookipedia.com"
        components.path = "/villagers"
        components.queryItems = [
            URLQueryItem(name: "game", value: "nh"),
            URLQueryItem(name: "nhdetails", value: "true"),
            URLQueryItem(name: "birthmonth", value: month),
            URLQueryItem(name: "birthday", value: day)
        ]
        
        guard let url = components.url else { return print("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.setValue("e9f885fa-7ba9-406f-9a02-df92fc463941", forHTTPHeaderField: "X-API-KEY")
        request.setValue("2.0.0", forHTTPHeaderField: "Accept-Version")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let results = try JSONDecoder().decode([Villager].self, from: data!)
                DispatchQueue.main.async {
                    completion(results[0])
                }
            } catch {
                print("Could not query data")
            }
            
        }
        .resume()
    }
    func getVillagers(completion: @escaping ([Villager]) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nookipedia.com"
        components.path = "/villagers"
        components.queryItems = [
            URLQueryItem(name: "game", value: "nh"),
            URLQueryItem(name: "nhdetails", value: "true")
        ]
        
        guard let url = components.url else { return print("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.setValue("e9f885fa-7ba9-406f-9a02-df92fc463941", forHTTPHeaderField: "X-API-KEY")
        request.setValue("2.0.0", forHTTPHeaderField: "Accept-Version")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let results = try JSONDecoder().decode([Villager].self, from: data!)
                DispatchQueue.main.async {
                    completion(results)
                }
            } catch {
                print("Could not query data")
            }
            
        }
        .resume()
    }
    func getVillagersMonth(month: String, completion: @escaping ([Villager]) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nookipedia.com"
        components.path = "/villagers"
        components.queryItems = [
            URLQueryItem(name: "game", value: "nh"),
            URLQueryItem(name: "nhdetails", value: "true"),
            URLQueryItem(name: "birthmonth", value: month),
        ]
        
        guard let url = components.url else { return print("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.setValue("e9f885fa-7ba9-406f-9a02-df92fc463941", forHTTPHeaderField: "X-API-KEY")
        request.setValue("2.0.0", forHTTPHeaderField: "Accept-Version")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let results = try JSONDecoder().decode([Villager].self, from: data!)
                DispatchQueue.main.async {
                    completion(results)
                }
            } catch {
                print("Could not query data")
            }
            
        }
        .resume()
    }
    func getAnimals(query: String, completion: @escaping ([Animal]) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nookipedia.com"
        components.path = "/nh/\(query)"
        
        guard let url = components.url else { return print("Invalid URL") }
        
        var request = URLRequest(url: url)
        request.setValue("e9f885fa-7ba9-406f-9a02-df92fc463941", forHTTPHeaderField: "X-API-KEY")
        request.setValue("2.0.0", forHTTPHeaderField: "Accept-Version")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let results = try JSONDecoder().decode([Animal].self, from: data!)
                DispatchQueue.main.async {
                    completion(results)
                }
            } catch {
                print("Could not query data")
            }
            
        }
        .resume()
    }
    func getVariations(query: String, completion: @escaping ([Variations]) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nookipedia.com"
        components.path = "/nh/\(query)"
        
        guard let url = components.url else { return print("Invalid URL")}
        
        var request = URLRequest(url: url)
        request.setValue("e9f885fa-7ba9-406f-9a02-df92fc463941", forHTTPHeaderField: "X-API-KEY")
        request.setValue("2.0.0", forHTTPHeaderField: "Accept-Version")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let results = try JSONDecoder().decode([Variations].self, from: data!)
                DispatchQueue.main.async {
                    completion(results)
                }
            } catch {
                print("Could not query data")
            }
            
        }
        .resume()
    }
    func getVariationsSingle(query: String, completion: @escaping (Variations) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nookipedia.com"
        components.path = "/nh/\(query)"
        
        guard let url = components.url else { return print("Invalid URL")}
        
        var request = URLRequest(url: url)
        request.setValue("e9f885fa-7ba9-406f-9a02-df92fc463941", forHTTPHeaderField: "X-API-KEY")
        request.setValue("2.0.0", forHTTPHeaderField: "Accept-Version")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let results = try JSONDecoder().decode(Variations.self, from: data!)
                DispatchQueue.main.async {
                    completion(results)
                }
            } catch {
                print("Could not query data")
            }
            
        }
        .resume()
    }
    func getItems(query: String, completion: @escaping ([Item]) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nookipedia.com"
        components.path = "/nh/\(query)"
        
        guard let url = components.url else { return print("Invalid URL")}
        
        var request = URLRequest(url: url)
        request.setValue("e9f885fa-7ba9-406f-9a02-df92fc463941", forHTTPHeaderField: "X-API-KEY")
        request.setValue("2.0.0", forHTTPHeaderField: "Accept-Version")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let results = try JSONDecoder().decode([Item].self, from: data!)
                DispatchQueue.main.async {
                    completion(results)
                }
            } catch {
                print("Could not query data")
            }
            
        }
        .resume()
    }
    func getItemsSingle(query: String, completion: @escaping (Item) -> ()) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.nookipedia.com"
        components.path = "/nh/\(query)"
        
        guard let url = components.url else { return print("Invalid URL")}
        
        var request = URLRequest(url: url)
        request.setValue("e9f885fa-7ba9-406f-9a02-df92fc463941", forHTTPHeaderField: "X-API-KEY")
        request.setValue("2.0.0", forHTTPHeaderField: "Accept-Version")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                let results = try JSONDecoder().decode(Item.self, from: data!)
                DispatchQueue.main.async {
                    completion(results)
                }
            } catch {
                print("Could not query data")
            }
            
        }
        .resume()
    }
}

//Dummy Data

var AnimalDummy = [
    Animal(name: "Cherry Salmon", render_url: "https://dodo.ac/np/images/c/c0/Cherry_Salmon_NH.png", time: "4 PM – 9 AM", catchphrases: ["I caught a cherry salmon! It's the perfect topper for a marlin sundae!"])
]

var VillagerDummy = [
    Villager(birthday_month: "February", birthday_day: "13", id: "flg01", image_url: "https://dodo.ac/np/images/9/94/Ribbot_NH.png", name: "Ribbot", title_color: "bfbfbf", text_color: "5e5e5e", quote: "Never rest, never rust.", nh_details: NHDetails(clothing: "Simple Parka", clothing_variation: "Light Blue", house_exterior_url: "https://dodo.ac/np/images/4/42/House_of_Ribbot_NH_Model.png", house_wallpaper: "Circuit-Board Wall", house_flooring: "Future-Tech Flooring"))
]

// Color extension

#if os(iOS)
extension UIColor {
    convenience init?(hexString: String?) {
        let input: String! = (hexString ?? "")
            .replacingOccurrences(of: "#", with: "")
            .uppercased()
        var alpha: CGFloat = 1.0
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        switch (input.count) {
        case 3 /* #RGB */:
            red = Self.colorComponent(from: input, start: 0, length: 1)
            green = Self.colorComponent(from: input, start: 1, length: 1)
            blue = Self.colorComponent(from: input, start: 2, length: 1)
            break
        case 4 /* #ARGB */:
            alpha = Self.colorComponent(from: input, start: 0, length: 1)
            red = Self.colorComponent(from: input, start: 1, length: 1)
            green = Self.colorComponent(from: input, start: 2, length: 1)
            blue = Self.colorComponent(from: input, start: 3, length: 1)
            break
        case 6 /* #RRGGBB */:
            red = Self.colorComponent(from: input, start: 0, length: 2)
            green = Self.colorComponent(from: input, start: 2, length: 2)
            blue = Self.colorComponent(from: input, start: 4, length: 2)
            break
        case 8 /* #AARRGGBB */:
            alpha = Self.colorComponent(from: input, start: 0, length: 2)
            red = Self.colorComponent(from: input, start: 2, length: 2)
            green = Self.colorComponent(from: input, start: 4, length: 2)
            blue = Self.colorComponent(from: input, start: 6, length: 2)
            break
        default:
            NSException.raise(NSExceptionName("Invalid color value"), format: "Color value \"%@\" is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", arguments:getVaList([hexString ?? ""]))
        }
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func colorComponent(from string: String!, start: Int, length: Int) -> CGFloat {
        let substring = (string as NSString)
            .substring(with: NSRange(location: start, length: length))
        let fullHex = length == 2 ? substring : "\(substring)\(substring)"
        var hexComponent: UInt64 = 0
        Scanner(string: fullHex)
            .scanHexInt64(&hexComponent)
        return CGFloat(Double(hexComponent) / 255.0)
    }
}
#endif
