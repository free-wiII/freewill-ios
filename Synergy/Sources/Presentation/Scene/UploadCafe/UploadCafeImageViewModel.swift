//
//  UploadCafeImageViewModel.swift
//  Synergy
//
//  Created by 이승기 on 2023/10/12.
//

import SwiftUI
import PhotosUI

final class UploadCafeImageViewModel: ObservableObject {
  
  // MARK: - Properties
  
  @Published public var selectedImages = [UIImage]()
  @Published public var selectedItems = [PhotosPickerItem]()
  
  
  // MARK: - Public
  
  public func removeImage(index: Int) {
    selectedItems.remove(at: index)
  }
}
