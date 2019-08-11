//
//  ViewController.swift
//  SwiftSourceBase
//
//  Created by Anh Bui on 7/21/19.
//  Copyright © 2019 Anh Bui. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Localize
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {
    @IBOutlet weak var serverLabel: UILabel!
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var languagesSwitch: UISwitch!
    @IBOutlet weak var getButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var userListButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    // MARK: - Private variable
    let bag = DisposeBag()
    let viewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // multiple target
        displayServer()
        
        // Localize
        greetingLabel.text = "greeting".localize()
        
        // RxSwift
        setupRx()
        
        // Google sign in
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
    }

    // MARK: - Private method
    private func displayServer() {
        #if DEV
            serverLabel.text = "This is DEV server"
        #elseif STG
            serverLabel.text = "This is STAGING server"
        #else // PROD
            serverLabel.text = "This is PRODUCTION server"
        #endif
    }

    private func setupRx() {
        languagesSwitch.rx.isOn.changed
            .subscribe(onNext: { [weak self] (isOn) in
                guard let `self` = self else { return }

                self.localizeToggle(isVietnamese: isOn)
            })
            .disposed(by: bag)

        // Call API
        getButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] (_) in
                WindowPopup.showLoading()
                self?.viewModel.getUserInfo()
            })
            .disposed(by: bag)

        postButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] (_) in
                WindowPopup.showLoading()
                self?.viewModel.addNewUser()
            })
            .disposed(by: bag)
        
        userListButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: {[weak self] (_) in
                let attribute = ListUserVC.instantiate(name: StoryboardName.userStoryboard.rawValue)
                self?.navigationController?.pushViewController(attribute, animated: true)
            })
            .disposed(by: bag)
        
        loginButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: {[weak self] (_) in
//                self?.doLogin()
                let loginVC = LoginVC.instantiate(name: StoryboardName.authenticate.rawValue)
                self?.navigationController?.pushViewController(loginVC, animated: true)
            })
            .disposed(by: bag)
        
        googleLoginButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: {[weak self] (_) in
                self?.signInWithGoogle()
            })
            .disposed(by: bag)

        facebookLoginButton.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: {[weak self] (_) in
                self?.signInWithFacebook()
            })
            .disposed(by: bag)
        
        // Receive data
        viewModel.errorString.subscribe(onNext: { (error) in
            WindowPopup.hideLoading()
            Logger.error(error)
        })
        .disposed(by: bag)

        viewModel.userInfo.subscribe(onNext: {[weak self] (user) in
            WindowPopup.hideLoading()
            self?.handleUserInfo(user: user)
        })
        .disposed(by: bag)

        viewModel.newUser.subscribe(onNext: { (newUser) in
            WindowPopup.hideLoading()
            Logger.info("---xxx Add successfully roi: \(newUser)")
        })
        .disposed(by: bag)
        
        viewModel.loginData.subscribe(onNext: {[weak self] (data) in
            WindowPopup.hideLoading()
            self?.handleLoginSuccess(data: data)
        })
        .disposed(by: bag)
    }
    
    private func handleUserInfo(user: UserModel?) {
        if let user = user {
            UserDefaultTools.userInfo = user
        }
        Logger.info("Get user info successfully")
    }
    
    private func handleLoginSuccess(data: LoginData) {
        Logger.warning("login data: \(data)")
        WindowPopup.showAlert("Login thành công rồi", title: "Chúc mừng", yesBlock: {
            print("---xxx yes rồi")
            // save token
            if let token = data.token {
                UserDefaultTools.accessToken = token
            }
        }) {
            print("---xxx no rồi")
        }
    }
    
    private func doLogin() {
        var param = LoginReq()
        param.email = "eve.holt@reqres.in"
        param.password = "cityslicka"
        
        WindowPopup.showLoading()
        viewModel.login(param)
    }
    
    private func localizeToggle(isVietnamese: Bool) {
        if isVietnamese {
            Localize.update(language: "vi-VN")
        } else {
            Localize.update(language: "en")
        }
    }
}

// MARK: - Facebook sign in
extension ViewController {
    private func signInWithFacebook() {
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["email", "public_profile"], from: self) {[weak self] (result, error) in
            guard let `self` = self else { return }
            Logger.info("resurl - \(result)")
            Logger.info("error - \(error)")
            
            if error == nil {
                let fbloginresult : LoginManagerLoginResult = result!
                
                if !fbloginresult.isCancelled {
                    // save token
//                    self.socialToken = fbloginresult.token.tokenString
//                    self.returnFBUserData()
                }
            } else {
                WindowPopup.showAlert(error?.localizedDescription ?? "")
//                self.showConfirmAlert(message: (error?.localizedDescription)!, handler: {})
            }
        }
    }
    
    private func getFBUserInfo() {
        if AccessToken.current != nil {
            let request = GraphRequest(graphPath: "me",
                                       parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email, gender, birthday"])
            request.start(completionHandler: { [weak self] (_, result, error) in
                guard let `self` = self else { return }
                
                if (error == nil) {
                    if let resultDict = result as? [String: Any] {
//                        self.userSocialProfile = resultDict
//                        if let socialID = resultDict["id"] as? String {
//                            self.currentSocialDriver = .FB
//                            self.serviceCheckSocialIdIsExist(socialId: socialID)
//                        } else {
//                            self.showConfirmAlert(message: "Cannot get social ID", handler: {})
//                        }
                    }
                }
            })
        }
    }
}

// MARK: - Google sign in
extension ViewController: GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!,
              didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            Logger.error("\(error.localizedDescription)")
        } else {
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
            Logger.info("\(user)")
        }
    }
    
    private func signInWithGoogle() {
        GIDSignIn.sharedInstance().signOut()
        GIDSignIn.sharedInstance()?.signIn()
    }
}
