//
//  CafeDetailViewModel.swift
//  Synergy
//
//  Created by 이승기 on 2023/09/22.
//

import SwiftUI
import Combine
import MapKit

final class CafeDetailViewModel: ObservableObject {
  
  // MARK: - Properties
  
  private var cancellables = Set<AnyCancellable>()
  
  private let cafeDetailUseCase: CafeDetailUseCase
  
  @Published var isLoading = false
  @Published var name: String = ""
  @Published var images = [String]()
  @Published var likeCount = 0
  @Published var isBookmarked = false
  @Published var isLiked = false
  @Published var ratings = [Rating]()
  @Published var location = Location(lng: 37.5666791,
                                     lat: 126.9782914,
                                     distance: 0,
                                     address: "")
  @Published var featuresReviews = [Review]()
  
  @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.5666791, longitude: 126.9782914), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
  
  
  // MARK: - Initializers
  
  init() {
    let repository = SynergyRepository(service: .init(.stub))
    self.cafeDetailUseCase = .init(repository: repository)
  }
  
  
  // MARK: - Public
  
  public func fetchCafeDetail() {
    isLoading = true
    
    cafeDetailUseCase.execute()
      .subscribe(on: DispatchQueue.global())
      .receive(on: DispatchQueue.main)
      .sink { [weak self] completion in
        // completion
        print(completion)
        self?.isLoading = false
      } receiveValue: { [weak self] cafeDetail in
        guard let self else { return }
        self.name = cafeDetail.name
        self.images = cafeDetail.images
        self.likeCount = cafeDetail.likeCount
        self.isBookmarked = cafeDetail.isBookmarked
        self.isLiked = cafeDetail.isLiked
        self.ratings = cafeDetail.ratings
        self.location = cafeDetail.location
        self.featuresReviews = cafeDetail.featuredReviews
        
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: cafeDetail.location.lat, longitude: cafeDetail.location.lng), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
      }
      .store(in: &cancellables)
  }
}
