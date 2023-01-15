//
//  OverlayCard.swift
//
//
//  Created by Norikazu Muramoto on 2022/10/17.
//

import SwiftUI

struct OverlayCard<MultiMedia>: View where MultiMedia: View {
    
    @Namespace var namespace: Namespace.ID
    
    private var title: String
    
    private var subTitle: String
    
    private var headline: String
    
    private var detail: String
    
    private var aspectRatio: CGFloat
    
    private var cornerRadius: CGFloat = 16
    
    private var multiMedia: () -> MultiMedia
    
    init(
        _ title: String,
        subTitle: String = "",
        headline: String = "",
        detail: String = "",
        aspectRatio: CGFloat = 1,
        @ViewBuilder multiMedia: @escaping () -> MultiMedia
    ) {
        self.title = title
        self.subTitle = subTitle
        self.headline = headline
        self.detail = detail
        self.aspectRatio = aspectRatio
        self.multiMedia = multiMedia
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(headline)
                .font(.footnote)
                .foregroundColor(.secondary)
                .lineLimit(1)
            Color.clear
                .aspectRatio(aspectRatio, contentMode: .fit)
                .overlay {
                    multiMedia()
                }
                .overlay(alignment: .bottom) {
                    VStack {
                        if !title.isEmpty {
                            Text(title)
                                .foregroundColor(.white)
                                .bold()
                        }
                        if !headline.isEmpty {
                            Text(headline)
                                .font(.footnote)
                                .foregroundColor(.white)
                        }
                        Text(detail)
                            .font(.footnote)
                            .foregroundColor(.white)

                    }
                    .frame(height: 88)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(.ultraThinMaterial)
                    .background(.black.opacity(0.3))
                }
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color(UIColor.lightGray).opacity(0.5), lineWidth: 1)
                }
                .cornerRadius(cornerRadius)
                .contentShape(Rectangle())
                .frame(minWidth: 160)
        }

    }
}


struct OverlayCard_Previews: PreviewProvider {
    
    static var url: URL = URL(string: "https://storage.mantan-web.jp/images/2022/06/10/20220610dog00m200046000c/002_size4.jpg")!
    
    static var previews: some View {
        Group {
            OverlayCard("TITLE", subTitle: "SUBTITLE", headline: "HEADLINE", detail: "DETAILDETAILDETAIL", aspectRatio: 2/3) {
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray
                }
            }
//            .frame(width: 380)
        }
        .previewLayout(.sizeThatFits)
    }
}
