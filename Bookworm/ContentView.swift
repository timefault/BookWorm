//
//  ContentView.swift
//  Bookworm
//
//  Created by Woody Nichols on 6/20/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors:[
        NSSortDescriptor(keyPath: \Book.title, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView
        {
            List {
                ForEach(books) { book in
                    NavigationLink(destination: DetailView(book: book), label:
                                    {HStack(
                                        content: {
                                            EmojiRatingView(rating: book.rating).font(.largeTitle)
                                            VStack(alignment: .leading, content: {
                                                Text(book.title ?? "Unknown Title").font(.headline)
                                                Text(book.author ?? "Unknown Author").foregroundColor(.secondary)
                                            }
                                            )
                                            
                                        }
                                    )}
                                   
                    )
                }.onDelete(perform: deleteBooks)
            }
            
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {showingAddScreen.toggle()}, label: {Label("Add Book", systemImage: "plus")})
                }
            }.sheet(isPresented: $showingAddScreen, content: {AddBookView()})
        }
    }
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
