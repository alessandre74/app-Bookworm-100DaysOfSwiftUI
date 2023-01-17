//
//  AddBookView.swift
//  Bookworm
//
//  Created by Alessandre Livramento on 12/01/23.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Mystery"
    @State private var review = ""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    @State var isEnableButtonSave = false

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)

                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }

                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
            }
            .navigationTitle("Add Book")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Save") {
                        if title.isRealEmpty || author.isRealEmpty || review.isRealEmpty {
                            isEnableButtonSave = true
                        } else {
                            let addBooks = [
                                "title": title,
                                "author": author,
                                "rating": Int16(rating),
                                "genre": genre,
                                "review": review,
                            ] as [String: Any]

                            DataController().addBooks(moc: moc, books: addBooks, dismiss: dismiss)
                        }
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 14).bold())
                            .foregroundColor(.red)
                    }
                }
            }
            .alert("Warning", isPresented: $isEnableButtonSave) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text("Required fields!")
            }
        }
        .preferredColorScheme(.dark)
    }
    
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
            .preferredColorScheme(.dark)
    }
}
