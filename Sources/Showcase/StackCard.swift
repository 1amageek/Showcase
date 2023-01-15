//
//  StackCard.swift
//
//
//  Created by Norikazu Muramoto on 2022/10/17.
//

import SwiftUI

public struct StackCard<MultiMedia>: View where MultiMedia: View {
    
    @Namespace var namespace: Namespace.ID
    
    private var title: String
    
    private var subTitle: String
    
    private var headline: String
    
    private var detail: String
    
    private var aspectRatio: CGFloat
    
    private var cornerRadius: CGFloat = 8
    
    private var multiMedia: () -> MultiMedia
    
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
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            VStack(alignment: .leading) {
                Text(headline)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                Text(title)
                    .font(.title2)
                    .lineLimit(2)
                Text(subTitle)
                    .foregroundColor(.secondary)
                    .font(.title2)
                    .lineLimit(2)
            }
            .fixedSize(horizontal: false, vertical: true)
            
            Color.clear
                .aspectRatio(aspectRatio, contentMode: .fit)
                .overlay {
                    multiMedia()
                }
                .overlay(alignment: .bottom) {
                    VStack {
                        Text(detail)
                            .font(.footnote)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .padding(EdgeInsets(top: 18, leading: 10, bottom: 10, trailing: 10))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background {
                        LinearGradient(gradient: Gradient(colors: [.clear, .black.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                        
                    }
                }
                .overlay {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color(UIColor.lightGray).opacity(0.5), lineWidth: 1)
                }
                .cornerRadius(cornerRadius)
        }
        .contentShape(Rectangle())
        .frame(minWidth: 160)
    }
}


struct StackCard_Previews: PreviewProvider {
    
    static var url: URL = URL(string: "https://storage.mantan-web.jp/images/2022/06/10/20220610dog00m200046000c/002_size4.jpg")!
    
    static var previews: some View {
        Group {
            StackCard("TITLE", subTitle: "SUBTITLE", headline: "HEADLINE", detail: "DETAILDETAILDETAIL", aspectRatio: 3/2) {
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
