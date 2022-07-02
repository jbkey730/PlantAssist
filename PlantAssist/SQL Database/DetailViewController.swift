//
//  DetailViewController.swift
//  PlantAssist
//
//  Created by Jacob Lamkey on 7/1/22.
//

import SwiftUI

struct DetailViewController: View {
    @EnvironmentObject var viewDataBase: ViewDataBase
    @Environment(\.presentationMode) var presentationMode
    let item: postDataBase
    @State var title = ""
    @State var post = ""
    
    var body: some View {
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
                .onAppear(perform: {
                    self.title = item.title
                    self.post = item.post
                })
        }
        
        .navigationBarTitle("Edit Post", displayMode: .inline)
        .navigationBarItems(trailing: trailing)
    }
    var trailing: some View {
        Button(action: {
            //update post
            if title != "" && post != "" {
                let parameters: [String: Any] = ["id":item.ID, "title":title,"post":post]
                viewDataBase.updatePost(parameters: parameters)
                viewDataBase.fetchPost()
                presentationMode.wrappedValue.dismiss()

            }
        }, label: {
            Text("Save")
    })
    }
    
}//end struct

//struct DetailViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailViewController()
//    }
//}
