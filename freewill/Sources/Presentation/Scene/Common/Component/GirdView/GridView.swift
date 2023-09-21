//
//  GridView.swift
//  freewill
//
//  Created by 이승기 on 2023/09/08.
//

import SwiftUI

public struct GridView<Content, Item>: View where Content: View {
  
  private let gridWidth: CGFloat
  private let spacing: CGFloat
  private let items: [Item]
  private let alignment: HorizontalAlignment
  private let content: (Item) -> Content
  
  public init(
    gridWidth: CGFloat,
    spacing: CGFloat,
    items: [Item],
    alignment: HorizontalAlignment = .leading,
    @ViewBuilder content: @escaping (Item) -> Content
  ) {
    self.gridWidth = gridWidth
    self.spacing = spacing
    self.items = items
    self.alignment = alignment
    self.content = content
  }
  
  public var body: some View {
    InnerGrid<Content, Item>(
      width: gridWidth,
      spacing: self.spacing,
      items: self.items,
      alignment: self.alignment,
      content: self.content
    )
  }
}

private struct InnerGrid<Content, Item>: View where Content: View {
  
  private let width: CGFloat
  private let spacing: CGFloat
  private let items: [Item]
  private let alignment: HorizontalAlignment
  private let content: (Item) -> Content
  private let indices: [Int]
  private let gridCalculator = GridCalculator()
  @State var itemSizes: [CGSize] = []
  
  init(
    width: CGFloat,
    spacing: CGFloat,
    items: [Item],
    alignment: HorizontalAlignment = .leading,
    @ViewBuilder content: @escaping (Item) -> Content
  ) {
    self.width = width
    self.items = items
    self.spacing = spacing
    self.alignment = alignment
    self.content = content
    self.indices = items.enumerated().map { $0.offset }
  }
  
  var body : some View {
    VStack(alignment: alignment, spacing: spacing) {
      ForEach(gridCalculator.calculate(availableWidth: width, items: indices, sizeItems: itemSizes, cellSpacing: spacing), id: \.self) { row in
        HStack(spacing: self.spacing) {
          ForEach(row, id: \.self) { index in
            ChildSizeReader(size: self.$itemSizes) {
              self.content(items[index])
            }
          }
        }.padding(.horizontal, self.spacing)
      }
    }
    .padding(.top, spacing)
    .frame(width: width)
  }
}

struct ChildSizeReader<Content: View>: View {
  @Binding var size: [CGSize]
  let content: () -> Content
  var body: some View {
    ZStack {
      content()
        .fixedSize()
        .background(
          GeometryReader { proxy in
            Color.clear
              .preference(key: SizePreferenceKey.self, value: proxy.size)
          }
        )
    }
    .onPreferenceChange(SizePreferenceKey.self) { preferences in
      self.size.append(preferences)
    }
  }
}

struct SizePreferenceKey: PreferenceKey {
  typealias Value = CGSize
  static var defaultValue: Value = .zero
  
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
    _ = nextValue()
  }
}
