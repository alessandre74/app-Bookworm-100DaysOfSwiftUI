//
//  DataController.swift
//  Bookworm
//
//  Created by Alessandre Livramento on 12/01/23.
//

import CoreData
import SwiftUI

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")

    var preview: NSManagedObjectContext {
        container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "dev/null")
        return container.viewContext
    }

    init() {
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolve Error: \(error)")
            }
        }
    }

    func previewBooks() -> Book {
        let book = Book(context: container.viewContext)
        book.id = UUID()
        book.title = "Book Mystery"
        book.author = "Author Mystery"
        book.rating = Int16(4)
        book.genre = "Mystery"
        book.review = "Description Mystery"
        return book
    }

    func addBooks(moc: NSManagedObjectContext, books: [String: Any], dismiss: DismissAction) {
        let book = Book(context: moc)
        book.id = UUID()
        book.title = books["title"] as? String
        book.author = books["author"] as? String
        book.rating = books["rating"] as! Int16
        book.genre = books["genre"] as? String
        book.review = books["review"] as? String

        try? moc.save()
        dismiss()
    }

    func deleteBooks(at offsets: IndexSet, books: FetchedResults<Book>, moc: NSManagedObjectContext) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }

    func deleteBooks(moc: NSManagedObjectContext, book: Book, dismiss: DismissAction) {
        moc.delete(book)
        try? moc.save()
        dismiss()
    }
}

extension String {
    var isRealEmpty: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
