//
//  FilterCriteriaSelector.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/07.
//

import SwiftUI

struct FilterCriteriaSelector: View {
  
  // MARK: - Properties
  
  @Binding var selectedCriteria: FilterCriteria
  
  
  // MARK: - Views
  
  var body: some View {
    ZStack(alignment: .bottom, content: {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(spacing: 8) {
          ForEach(FilterCriteria.allCases, id: \.self) { criteria in
            Button {
              selectedCriteria = criteria
            } label: {
              FilterCriteriaChip(
                isSelected: .constant(selectedCriteria == criteria),
                criteria: criteria)
            }
          }
        }
        .padding(.horizontal, 16)
      }
      .frame(maxHeight: .infinity)
      
      Divider()
        .overlay(Color.fwGray30)
    })
    .frame(height: 72)
    .background(Color.fwWhite)
  }
}


// MARK: - Preview

struct FilterCriteriaSelector_Preview: PreviewProvider {
  static var previews: some View {
    VStack {
      FilterCriteriaSelector(selectedCriteria: .constant(.best))
      
      Spacer()
    }
    .background(Color.fwGray30)
  }
}
