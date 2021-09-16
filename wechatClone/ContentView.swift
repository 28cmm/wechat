//
//  ContentView.swift
//  wechatClone
//
//  Created by Yilei Huang on 2021-09-15.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView()
    }
}
let HEIGHT9 = UIScreen.main.bounds.height/9
let WIDTH9 = UIScreen.main.bounds.width/9

struct LoginView:View{
    @State var userTF = ""
    @State var passwordTF = ""
    var body: some View{
        VStack(){

            HStack{
                Text("Log in Via Wechat/QQ/Email")
                    .font(.title)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding(.top,100)
            Spacer()
            HStack{
                Text("Account")
                Spacer()
                TextField("wechat/QQ/email",text:$userTF)
                Spacer()
            }
            Divider()
                .padding(.bottom)

            HStack{
                Text("Password")
                Spacer()
                SecureField("Enter password",text:$passwordTF)
                Spacer()
            }
            Divider()
                .padding(.bottom,100)
            Button(action:{}){
                Text("Log in")
                    .foregroundColor(.white)
            }
//            .disabled(userTF)
            .frame(maxWidth:.infinity)
            .padding(.vertical,20)
            .background(Color.green)
            .cornerRadius(7)

            Spacer()
            HStack{
                Button(action:{}){
                    Text("Unable to Log In?")
                        .foregroundColor(Color(#colorLiteral(red: 0.4512549639, green: 0.5040833354, blue: 0.6149758101, alpha: 1)))
                }
                Divider().background(Color.gray)
                    .frame(height:HEIGHT9/5)
                Button(action:{}){
                    Text("More Options")
                        .foregroundColor(Color(#colorLiteral(red: 0.4512549639, green: 0.5040833354, blue: 0.6149758101, alpha: 1)))
                }
            }
            .frame(height:HEIGHT9)


        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
