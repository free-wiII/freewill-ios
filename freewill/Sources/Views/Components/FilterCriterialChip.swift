//
//  FilterCriterialChip.swift
//  freewill
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI

struct FilterCriterialChip: View {
  
  // MARK: - Properties
  
  @Binding var isSelected: Bool
  let criterial: FilterCriteria
  

  // MARK: - Views
  
  var body: some View {
    Text(criterial.description)
      .font(.system(size: 13, weight: .bold))
      .foregroundColor(isSelected ? Color.fwWhite : Color.fwBlack)
      .padding(.horizontal, 16)
      .padding(.vertical, 12)
      .background(isSelected ? Color.fwBlack : Color.fwGray20)
      .cornerRadius(14)
  }
}


// MARK: - Preview

struct FilterCriterialChip_Preview: PreviewProvider {
  static var previews: some View {
    VStack {
      ForEach(FilterCriteria.allCases, id: \.self) { criteria in
        FilterCriterialChip(isSelected: .constant(Bool.random()), criterial: criteria)
      }
    }
    .previewLayout(.sizeThatFits)
  }
}
