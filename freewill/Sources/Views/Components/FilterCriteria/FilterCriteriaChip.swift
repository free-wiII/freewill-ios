//
//  FilterCriteriaChip.swift
//  freewill
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI

struct FilterCriteriaChip: View {
  
  // MARK: - Properties
  
  @Binding var isSelected: Bool
  let criteria: FilterCriteria
  

  // MARK: - Views
  
  var body: some View {
    Text(criteria.description)
      .font(.system(size: 13, weight: .bold))
      .foregroundColor(isSelected ? Color.fwWhite : Color.fwBlack)
      .padding(.horizontal, 16)
      .padding(.vertical, 12)
      .background(isSelected ? Color.fwBlack : Color.fwGray20)
      .cornerRadius(14)
  }
}


// MARK: - Preview

struct FilterCriteriaChip_Preview: PreviewProvider {
  static var previews: some View {
    VStack {
      ForEach(FilterCriteria.allCases, id: \.self) { criteria in
        FilterCriteriaChip(isSelected: .constant(Bool.random()), criteria: criteria)
      }
    }
    .previewLayout(.sizeThatFits)
  }
}
