//
//  LoginView.swift
//  cloudrm
//
//  Created by Jean Laura on 14/01/25.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var authvm: AuthViewModel
    
    @State var txtEmail = ""
    @State var txtKey = ""
    @State var txtError: String?
    
    @State var isLoading = false
    @State var isCreateOn = false
    @State var isShowKey1 = false
    
    private let cornerField = RectangleCornerRadii(topLeading: 8, bottomLeading: 8)
    private let cornerField2 = RectangleCornerRadii(bottomTrailing: 8, topTrailing: 8)
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
                VStack {
                    Image(systemName: "lock.icloud")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundStyle(.indigo)
                        .padding()
                    VStack {
                        Text("Access your cloud")
                            .font(.title)
                        Text("All your files, anywhere")
                            .font(.caption)
                    }
                }
                
                Spacer()
                
                VStack(spacing: 15) {
                    
                    HStack {
                        VStack {
                            Text("Email")
                                .font(.system(size: 14))
                        }
                        .frame(width: 100, height: 40, alignment: .center)
                        .background {
                            UnevenRoundedRectangle(cornerRadii: cornerField)
                                .foregroundStyle(.gray.opacity(0.2))
                        }
                        TextField("example@provider.***", text: $txtEmail)
                            .font(.system(size: 14))
                            .textInputAutocapitalization(.never)
                            .keyboardType(.emailAddress)
                    }
                    .frame(width: 350, height: 40, alignment: .leading)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 0.3)
                    }
                    
                    HStack {
                        VStack {
                            Text("Key")
                                .font(.system(size: 14))
                        }
                        .frame(width: 100, height: 40, alignment: .center)
                        .background {
                            UnevenRoundedRectangle(cornerRadii: cornerField)
                                .foregroundStyle(.gray.opacity(0.2))
                        }
                        if isShowKey1 {
                            TextField("12345678", text: $txtKey)
                                .font(.system(size: 14))
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                                .textContentType(.password)
                        } else {
                            SecureField("12345678", text: $txtKey)
                                .font(.system(size: 14))
                                .textInputAutocapitalization(.never)
                                .keyboardType(.emailAddress)
                        }
                        
                        Button {
                            isShowKey1.toggle()
                        } label: {
                            VStack {
                                Image(systemName: isShowKey1 ? "eye.fill" : "eye.slash")
                                    .foregroundStyle(.gray)
                            }
                            .frame(width: 60, height: 40, alignment: .center)
                            .background {
                                UnevenRoundedRectangle(cornerRadii: cornerField2)
                                    .foregroundStyle(.gray.opacity(0.2))
                            }
                        }
                    }
                    .frame(width: 350, height: 40, alignment: .leading)
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 0.3)
                    }
                    
                    
                    VStack(spacing: 0) {
                        Button {
                            Task {
                                isLoading.toggle()
                                await authvm.login(email: txtEmail, password: txtKey)
                                txtError = authvm.error?.localizedDescription ?? ""
                                isLoading.toggle()
                            }
                        } label: {
                            VStack {
                                HStack {
                                    if isLoading {
                                        ProgressView()
                                    } else {
                                        Text("Sign In")
                                    }
                                    
                                    Image(systemName: "key.horizontal.fill")
                                }
                                .foregroundStyle(.black)
                            }
                            .frame(width: 350, height: 40, alignment: .center)
                            .background {
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundStyle(.indigo)
                                    .opacity(isLoading ? 0.6 : 1)
                            }
                        }
                        .disabled(isLoading)
                        
                        VStack {
                            Text(txtError ?? "")
                                .font(.caption)
                        }
                        .frame(width: 350, height: 40, alignment: .leading)
                        
                    }
                    .padding()
                }
                .padding()
                
                Spacer()
                
                Button("Create an account", systemImage: "person.icloud.fill") {
                    isCreateOn = true
                }
                .foregroundStyle(.indigo)
                
            }
            .sheet(isPresented: $isCreateOn) {
                txtError = nil
            } content: {
                RegisterView(authvm: $authvm)
                    .presentationDetents([.height(500), .height(501)])
            }
            
        }
    }
}

#Preview {
    LoginView(authvm: .constant(AuthViewModel()))
}
