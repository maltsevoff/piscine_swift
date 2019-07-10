//
//  ViewController.swift
//  rush00_1
//
//  Created by Oleksandr MALTSEV on 6/30/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit
import SafariServices
import AuthenticationServices

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var helpLabel: UILabel!
    @IBAction func authenticationButton(_ sender: UIButton) {
        authUsingInta()
    }
    
    var authSession: ASWebAuthenticationSession?
    var token: String!
    var login: String?
    var id: Int!
    
    let apiUrl = "https://api.intra.42.fr/"
    let callBackUrl = "idiot.app%3A%2F%2Fidiot.app"
    let clientID = "b6963484b1e51cb154c83ac53655924179d717b55ddfe15caeda33e135bd73a2"
    let clientSecret = "b1595e069ffb6842c092f0e7befb654611d82b640e9ff97878c04b8e5d3e7522"
    
    func authUsingInta () {
        let authUrl = apiUrl + "oauth/authorize?client_id=\(clientID)&redirect_uri=\(callBackUrl)&response_type=code"
//        let authUrl = "https://api.intra.42.fr/oauth/authorize?client_id=b6963484b1e51cb154c83ac53655924179d717b55ddfe15caeda33e135bd73a2&redirect_uri=idiot.app%3A%2F%2Fidiot.app&response_type=code"
        self.authSession = ASWebAuthenticationSession(url: URL(string: authUrl)!, callbackURLScheme: callBackUrl, completionHandler: { (callBack: URL?, error: Error?) in
            guard error == nil, let successUrl = callBack else { return }
            guard let code = URLComponents(string: successUrl.absoluteString)?.queryItems?.filter({$0.name == "code"}).first
                else { return }
            self.authorizateRequest(withCode: code)
            self.helpLabel.text = "Fuck you 😜"
            })
        self.authSession?.start()
    }
    
    func authorizateRequest(withCode aCode: URLQueryItem) {
        let url = URL(string: apiUrl + "oauth/token")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = "grant_type=authorization_code&client_id=\(clientID)&client_secret=\(clientSecret)&\(aCode)&redirect_uri=\(callBackUrl)".data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let dict = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(dict)
                    guard let token = dict["access_token"] as? String else { return }
                    self.token = token
                    AuthorizationService.setToken(token: token)
                    self.getMyLogin()
                    // Make TopicView !!!!!!!!!!!!!!
//                    DispatchQueue.main.async {
//
//                    }
                } catch (let error) {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func getMyLogin () {
        let url = URL(string: apiUrl + "v2/me")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        _ = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let dict = try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String, Any>
                    self.login = dict!["login"] as! String
                    self.id = dict!["id"] as! Int
                    self.getTopics()
                } catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    func getTopics () {
        let url = URL(string: apiUrl + "v2/topics.json")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        if let token = AuthorizationService.getToken() {
            request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                do {
                    let array = try JSONSerialization.jsonObject(with: data, options: []) as? Array<Dictionary<String,Any>>
                    for dict in array! {
                        //                        let name = dict["author"] as! String
                        let title = dict["name"] as! String
                        let date = dict["created_at"] as! String
                        
                        let author = dict["author"] as? Dictionary<String, Any>
                        let login = author!["login"] as! String
                        
                        topics.append(Topic(title: title, author: login, date: date))
                    }
                    DispatchQueue.main.async {
                        let vc = SecondViewController()
////                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "secondViewID") as! SecondViewController
                        self.navigationController?.pushViewController(vc, animated: true)
//                        self.changeView()
                    }
                } catch (let error) {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
//    func changeView() {
//        performSegue(withIdentifier: "segueNext", sender: "foo")
//    }
}

