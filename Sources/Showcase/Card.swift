//
//  Card.swift
//
//
//  Created by Norikazu Muramoto on 2022/10/17.
//

import SwiftUI

public enum CardStyle {
    case stack
    case overlay
}

public struct Card<MultiMedia>: View where MultiMedia: View {
    
    @Namespace var namespace: Namespace.ID
    
    private var title: String
    
    private var subTitle: String
    
    private var headline: String
    
    private var detail: String
    
    private var aspectRatio: CGFloat
    
    private var cornerRadius: CGFloat = 8
    
    private var multiMedia: () -> MultiMedia
    
    private var style: CardStyle
    
    init(
        style: CardStyle,
        title: String,
        subTitle: String = "",
        headline: String = "",
        detail: String = "",
        aspectRatio: CGFloat = 1,
        @ViewBuilder multiMedia: @escaping () -> MultiMedia
    ) {
        self.style = style
        self.title = title
        self.subTitle = subTitle
        self.headline = headline
        self.detail = detail
        self.aspectRatio = aspectRatio
        self.multiMedia = multiMedia
    }
    
    public init(
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
        self.style = .stack
    }
    
    public init(
        _ url: URL?,
        title: String,
        subTitle: String = "",
        headline: String = "",
        detail: String = "",
        aspectRatio: CGFloat = 1
    ) where MultiMedia == AsyncImage<_ConditionalContent<AnyView, EmptyView>> {
        self.title = title
        self.subTitle = subTitle
        self.headline = headline
        self.detail = detail
        self.aspectRatio = aspectRatio
        self.multiMedia = {
            AsyncImage(url: url) { image in
                AnyView(image
                    .resizable()
                    .scaledToFill())
            } placeholder: {
                EmptyView()
            }
        }
        self.style = .stack
    }
    
    
    public var body: some View {
        switch style {
            case .stack:
                StackCard(title, subTitle: subTitle, headline: headline, detail: detail, aspectRatio: aspectRatio, multiMedia: multiMedia)
            case .overlay:
                OverlayCard(title, subTitle: subTitle, headline: headline, detail: detail, aspectRatio: aspectRatio, multiMedia: multiMedia)
        }
    }
    
    @ViewBuilder
    public func cardStyle(_ style: CardStyle) -> some View {
        switch style {
            case .stack:
                StackCard(title, subTitle: subTitle, headline: headline, detail: detail, aspectRatio: aspectRatio, multiMedia: multiMedia)
            case .overlay:
                OverlayCard(title, subTitle: subTitle, headline: headline, detail: detail, aspectRatio: aspectRatio, multiMedia: multiMedia)
        }
    }
}


struct Card_Previews: PreviewProvider {
    
    static var url: URL = URL(string: "https://storage.mantan-web.jp/images/2022/06/10/20220610dog00m200046000c/002_size4.jpg")!
    
    static var previews: some View {
        Group {
            VStack(spacing: 16) {
                Card("TITLE", subTitle: "SUBTITLE", headline: "HEADLINE", detail: "DETAILDETAILDETAIL", aspectRatio: 3/2) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                }
                .cardStyle(.stack)
                .frame(width: 200)
                
                Card("TITLE", subTitle: "SUBTITLE", headline: "HEADLINE", detail: "DETAILDETAILDETAIL", aspectRatio: 2/3) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray
                    }
                }
                .cardStyle(.overlay)
                .frame(width: 200)
                
                Card(url, title: "TITLE")
                Card(url, title: "TITLE")
                    .cardStyle(.overlay)
            }
            .padding()
        }
        .previewLayout(.sizeThatFits)
    }
}
