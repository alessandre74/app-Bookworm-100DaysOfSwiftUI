//
//  DetailView.swift
//  Bookworm
//
//  Created by Alessandre Livramento on 12/01/23.
//

import CoreData
import SwiftUI

struct DetailView: View {
    var book: Book

    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

    @State private var showingDeleteAlert = false

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()

                HStack {
                    Text("\(DataController.formattedDate(date: book.date ?? Date.now))")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(Capsule()).offset(x: 5, y: -5)

                    Spacer()

                    Text(book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
            }

            Text(book.author ?? "Unknown Book")
                .font(.title)
                .foregroundColor(.secondary)

            Text(book.review ?? "Unknown Book")
                .padding()

            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
        }
        .navigationTitle(book.title ?? "Unknown Book")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                DataController().deleteBooks(moc: moc, book: book, dismiss: dismiss)
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let dataController = DataController()

        return DetailView(book: dataController.previewBooks())
            .environment(\.managedObjectContext, dataController.preview)
            .preferredColorScheme(.dark)
    }
}
