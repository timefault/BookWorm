//
//  DetailView.swift
//  Bookworm
//
//  Created by Woody Nichols on 6/27/22.
//

import SwiftUI

struct DetailView: View {
    let book: Book
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.75))
                    .clipShape(Capsule())
                    .offset(x: -5, y: -5)
            }
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)
            Text(book.review ?? "No review")
                .padding()
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $showingDeleteAlert, content: {
            Alert(title: Text("Delete Book"), message: Text("Really delete this book?"),
                  primaryButton: .default( Text("Cancel"), action: {}),    // how to cancel??
                  secondaryButton: .destructive(Text("Delete"), action: deleteBook)
        )}
        )
        .toolbar {
            Button(action: {showingDeleteAlert = true }, label: {Label("Delete this book?", systemImage: "trash")})
        }
        
    }
    func deleteBook() {
        moc.delete(book)
        
//        try? moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}
