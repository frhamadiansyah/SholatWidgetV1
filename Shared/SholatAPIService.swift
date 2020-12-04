//
//  SholatAPIService.swift
//  WaktuSholat
//
//  Created by Fandrian Rhamadiansyah on 24/10/20.
//

import Foundation

enum SholatAPIError : Error {
    case invalidURL
    case invalidSerialization
    case badHTTPResponse
    case error(NSError)
    case noData
}



class SholatAPIService {
    private let baseURL = "https://api.aladhan.com/v1/"
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    static let shared = SholatAPIService()
    
    var method: CalculationMethod = .muslimWorldLeague
    
    init() {
        self.getMethodFromUserDefaults()
    }
    
    
    
    func getMethodFromUserDefaults() {
        let savedMethodString = UserDefaults.standard.string(forKey: Def.method)
        
        let savedMethod = CalculationMethod.allCases.filter { (method) -> Bool in
            if method.info.name == savedMethodString {
                return true
            } else {
                return false
            }
        }
        if savedMethod.isEmpty{
            //            return .MuslimWorldLeague
            self.method = .muslimWorldLeague
        } else {
            //            return savedMethod[0]
            self.method = savedMethod[0]
        }
    }
    
    
    
    //    func getTodaySholatTime(latitude : Double, longitude : Double, completion : @escaping (Result<SholatTimings,SholatAPIError>) -> ()) {
    func getTodaySholatTimeFromCoordinates(latitude : Double, longitude : Double, completion : @escaping (Result<SholatTimings,SholatAPIError>) -> ()) {
        
        // get date
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        guard let url = URL(string: "\(baseURL)calendar?latitude=\(latitude)&longitude=\(longitude)&method=\(self.method.info.num)&month=\(month)&year=\(year)") else {
            completion(.failure(.invalidURL))
            return
        }
        executeDataTaskAndDecode(with: url) { (result : Result<Sholat, SholatAPIError>) in
            switch result {
            case .success(let response):
                completion(.success(response.sholatCalendar[day - 1].sholatSchedule))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    private func executeDataTaskAndDecode<D: Decodable>(with url : URL, completion : @escaping (Result<D, SholatAPIError>) -> ()) {
        urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(.error(error as NSError)))
                return
            }
            
            guard let httpresponse = response as? HTTPURLResponse, httpresponse.statusCode >= 200 && httpresponse.statusCode < 300 else {
                completion(.failure(.badHTTPResponse))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let model = try
                    self.jsonDecoder.decode(D.self, from: safeData)
                completion(.success(model))
                
            } catch {
                completion(.failure(.invalidSerialization))
            }
        }.resume()
    }
}
