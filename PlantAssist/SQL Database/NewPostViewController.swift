//
//  NewPostViewController.swift
//  PlantAssist
//
//  Created by Jacob Lamkey on 7/1/22.
//

import SwiftUI

struct NewPostViewController: View {
    @EnvironmentObject var viewDataBase: ViewDataBase
    @Binding var isPresented: Bool
    @Binding var title: String
    @Binding var post: String
    @State var isAlert = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text("Create New Post!")
                        .font(Font.system(size:16, weight: .bold))
                    
                    TextField("Title", text: $title)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    TextField("Write Something...", text: $post)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(6)
                        .padding(.bottom)
                    
                    Spacer()
                    
                }.padding()
                    .alert(isPresented: $isAlert, content: {
                        let title = Text("No data")
                        let message = Text("Please fill your title and post!")
                        return Alert(title: title, message: message)
                    })
            }
            
            .navigationBarTitle("New Post", displayMode: .inline)
            .navigationBarItems(leading: leading, trailing: trailing)
        }
        
    }
    var leading: some View {
        Button(action: {
            isPresented.toggle()
        }, label: {
            Text("Cancel")
    })
    }
    var trailing: some View {
        Button(action: {
            if title != "" && post != "" {
                let parameters: [String: Any] = ["title": title, "post": post]
                viewDataBase.createPost(parameters: parameters)
                viewDataBase.fetchPost()
                
                isPresented.toggle()
            } else {
                isAlert.toggle()
            }
        }, label: {
            Text("Post")
    })
    }
}

//struct NewPostViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        NewPostViewController()
//    }
//}
