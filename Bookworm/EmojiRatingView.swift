//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Alessandre Livramento on 12/01/23.
//

import SwiftUI

struct EmojiRatingView: View {
    let raring: Int16

    var body: some View {
        switch raring {
        case 1:
            Text("🙈")
        case 2:
            Text("😔")
        case 3:
            Text("🙂")
        case 4:
            Text("😊")
        default:
            Text("🤩")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(raring: 3)
            .preferredColorScheme(.dark)
    }
}
