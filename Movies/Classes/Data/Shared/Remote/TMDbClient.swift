//
//  TMDbClient.swift
//  Movies
//
//  Created by Rubens Pessoa on 4/12/18.
//  Copyright © 2018 Ilhasoft. All rights reserved.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import ObjectMapper

class TMDbClient {

    static let shared = TMDbClient()
    private let disposeBag = DisposeBag()
    private let cache = NSCache<NSString, UIImage>()

    private struct Constants {
        static func getMovieDetailUrl(by id: String) -> String {
            return "https://api.themoviedb.org/3/movie/\(id)"
        }

        static func getMovieCreditsUrl(by id: String) -> String {
            return "https://api.themoviedb.org/3/movie/\(id)/credits"
        }

        static func getMovieSearchUrl() -> String {
            return "https://api.themoviedb.org/3/search/movie"
        }

        static func getConfigurationUrl() -> String {
            return "https://api.themoviedb.org/3/configuration"
        }

        static func getApiKey() -> String {
            return "97654a302bf2873ea5887374cf650dd2"
        }

        static func getImageUrl(path: String) -> String? {
            guard let baseUrl = UserDefaults.standard.string(forKey: "baseUrl") else {
                return nil
            }

            let quality = "/w300"
            return "\(baseUrl)\(quality)\(path)"
        }
    }

    func getConfiguration() {
        let requestUrl = Constants.getConfigurationUrl()
        let parameters: Parameters = ["api_key": Constants.getApiKey()]

        request(.get,
                requestUrl,
                parameters: parameters,
                encoding: URLEncoding.default,
                headers: nil)
            .responseJSON()
            .subscribe(onNext: { (response) in
                switch response.result {
                case .success(let value):
                    if let value = value as? [String: Any],
                        let images = value["images"] as? [String: Any],
                        let baseUrl = images["base_url"] as? String {
                        UserDefaults.standard.setValue(baseUrl, forKey: "baseUrl")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            .disposed(by: disposeBag)
    }

    func searchMovie(by title: String, page: Int) -> Observable<MVMovieSearch> {
        let requestUrl = Constants.getMovieSearchUrl()
        let parameters = ["api_key": Constants.getApiKey(),
                          "language": "en-US",
                          "query": "\(title)",
            "page": "\(page)",
            "include_adult": "false"]

        return request(.get,
                       requestUrl,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: nil)
            .responseJSON()
            .flatMap { (response) -> Observable<MVMovieSearch> in
                switch response.result {
                case .failure(let error):
                    print(error.localizedDescription)
                    return Observable.empty()
                case .success(let value):
                    guard let value = value as? [String: Any],
                        let movieSearch = Mapper<MVMovieSearch>().map(JSON: value) else {
                            return Observable.empty()
                    }
                    return Observable.from(optional: movieSearch)
                }
        }
    }

    func getMovieDetail(by id: String) -> Observable<MVMovieDetail> {
        let requestUrl = Constants.getMovieDetailUrl(by: id)
        let parameters = ["api_key": Constants.getApiKey(),
                          "language": "en-US"]
        return request(.get,
                       requestUrl,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: nil)
            .responseJSON()
            .flatMap { (response) -> Observable<MVMovieDetail> in
                switch response.result {
                case .failure(let error):
                    print(error.localizedDescription)
                    return Observable.empty()
                case .success(let value):
                    guard let value = value as? [String: Any],
                        let movieDetail = Mapper<MVMovieDetail>().map(JSON: value) else {
                            return Observable.empty()
                    }
                    return Observable.from(optional: movieDetail)
                }
        }
    }

    func getMovieCredits(by id: String) -> Observable<MVMovieCredits> {
        let requestUrl = Constants.getMovieCreditsUrl(by: id)
        let parameters = ["api_key": Constants.getApiKey()]

        return request(.get,
                       requestUrl,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: nil)
            .responseJSON()
            .flatMap({ (response) -> Observable<MVMovieCredits> in
                switch response.result {
                case .failure(let error):
                    print(error.localizedDescription)
                    return Observable.empty()
                case .success(let value):
                    guard let value = value as? [String: Any],
                        let movieCredits = Mapper<MVMovieCredits>().map(JSON: value) else {
                            return Observable.empty()
                    }
                    return Observable.from(optional: movieCredits)
                }
            })
    }

    func getImage(by path: String) -> Observable<UIImage> {
        guard let requestUrl = Constants.getImageUrl(path: path) else {
            return Observable.empty()
        }
        if let cachedImage = cache.object(forKey: requestUrl as NSString) {
            return Observable.from(optional: cachedImage)
        } else {
            return request(.get,
                           requestUrl,
                           parameters: nil,
                           encoding: URLEncoding.default,
                           headers: nil)
                .responseData()
                .flatMap { (_, data) -> Observable<UIImage> in
                    guard let image = UIImage(data: data) else {
                        return Observable.empty()
                    }
                    self.cache.setObject(image, forKey: requestUrl as NSString)
                    return Observable.from(optional: image)
            }
        }
    }
}
