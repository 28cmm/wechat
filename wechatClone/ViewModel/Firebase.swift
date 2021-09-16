//
//  Firebase.swift
//  wechatClone
//
//  Created by Yilei Huang on 2021-09-16.
//

import SwiftUI
import Firebase

class FireBase: ObservableObject {
    static let shared = FireBase()
    let firestore = Firestore.firestore()
    @AppStorage("log_status") var log_Status = false

    func addUser(type:RegisterType,uid:String, completion:@escaping()->Void){
        let store = firestore.collection(Constant.user).document(uid)
        store.setData([
            "uid":uid,
            "email":Auth.auth().currentUser?.email ?? "N/A",
            "registerType":type.title,
            "name":Auth.auth().currentUser?.displayName ?? "N/A"
        ]){(err)in
            if let err = err{
                debugPrint(err.localizedDescription)
                return
            }
            print("success add,",uid)
            completion()

        }
    }

    func logoOut(){
        DispatchQueue.global(qos: .background).async {

            try? Auth.auth().signOut()
        }

        // Setting Back View To Login...
        withAnimation(.easeInOut){
            log_Status = false
        }
    }
}


