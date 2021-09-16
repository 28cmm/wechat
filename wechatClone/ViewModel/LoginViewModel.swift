//
//  LoginViewModel.swift
//  Calender
//
//  Created by Yilei Huang on 2021-08-24.
//

import SwiftUI
import AuthenticationServices
import CryptoKit
import Firebase

class LoginViewModel: ObservableObject {
    @Published var nonce = ""
    @AppStorage("log_status") var log_Status = false
    func authenticate(credential:ASAuthorizationAppleIDCredential){
        //getting token..
        guard let token = credential.identityToken else{
            print("error with firebase")
            return
        }

        guard let tokenString = String(data:token,encoding: .utf8) else{
            print("error with Token")
            return
        }
        let fireabseCrediential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString,rawNonce: nonce)
        Auth.auth().signIn(with: fireabseCrediential) { [self] res, err in
            if let err = err{
                print(err.localizedDescription)
                return
            }
            //User Successfully Logged into Firebase
            print("Logged IN Sucess")


            isExist {res in
                if res{
                    withAnimation{
                        self.log_Status = true
                    }
                }else{
                    FireBase.shared.addUser(type: .apple, uid: Auth.auth().currentUser!.uid){
                        withAnimation{
                            self.log_Status = true
                        }
                    }
                }
            }





        }

    }

    func isExist(completion:@escaping(Bool)->Void) {
        var allUsers = [String]()
        FireBase.shared.firestore.collection(Constant.user).getDocuments { snapShots, err in
            if let err = err{
                debugPrint(err.localizedDescription)
            }
            snapShots?.documents.forEach({ snapShot in
                let data = snapShot.data()
                let user = Member(dictionary:data)
                allUsers.append(user.uid!)
            })
            if allUsers.contains(Auth.auth().currentUser!.uid){
                print("have user")
                completion(true)
            }else{

                completion(false)
            }
        }

    }
}


func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
    }.joined()

    return hashString
}

func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length

    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
        }

        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }

            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }

    return result
}


struct Constant{
    static let user = "USER"
    static let group = "GROUP"
    static let message = "MESSAGE"

    static func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}

    enum RegisterType{
        case email
        case apple

        var title: String {
            switch self {
                case .email:
                    return "email"
                case .apple:
                    return "apple"
            }
        }
    }
