//
//  SwiftUIView.swift
//  PlantAssist
//
//  Created by Jacob Lamkey on 6/30/22.
//

import SwiftUI

struct DataBaseViewController: View {
    //@ObservedObject var viewDataBase = ViewDataBase()
    var body: some View {
        HomeView().environmentObject(ViewDataBase())
    }
}

struct HomeView: View {
    @EnvironmentObject var viewDataBase: ViewDataBase
    @State var isPresentedNewPost = false
    @State var title = ""
    @State var post = ""
    
    var body: some View {
        NavigationView {
            List{
                ForEach(viewDataBase.items, id: \.id) {item in
                    NavigationLink(
                        destination: DetailViewController(item: item),
                    label: {
                        VStack(alignment: .leading) {
                            Text(item.title)
                        Text(item.post).font(.caption).foregroundColor(.gray)
                        }
                    })
                }.onDelete(perform: deletePost).environmentObject(ViewDataBase())
                
            }.listStyle(InsetListStyle())
            
            .navigationTitle("Posts")
            .navigationBarItems(trailing: plusButton)
        }.sheet(isPresented: $isPresentedNewPost, content: {
            NewPostViewController(isPresented: $isPresentedNewPost, title: $title, post: $post)
        }).environmentObject(ViewDataBase())
    }
    
    private func deletePost(indexSet: IndexSet) {
        let id = indexSet.map { viewDataBase.items[$0].id }
        DispatchQueue.main.async{
            let parameters: [String: Any] = ["id": id[0]]
            self.viewDataBase.deletePost(parameters: parameters)
            self.viewDataBase.fetchPost()
        }
    }
    
    var plusButton: some View {
        Button(action: {
            isPresentedNewPost.toggle()
        }, label: {
            Image(systemName: "plus")
        })
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DataBaseViewController()
    }
}
