//
//  ForecastCityCellViewTest.swift
//  WeatherChallengeSnapshotTests
//
//  Created by Jonashio on 20/8/24.
//

import XCTest
@testable import WeatherChallenge
import SwiftUI
import SnapshotTesting

final class ForecastCityCellViewTest: XCTestCase {
    func test_load_view() {
        let cellView  = ForecastCityCellView(city: .fakeItem(), namespace: Namespace().wrappedValue, isSelected: false, mainAction: {}, action: { _ in })
        let view: UIView = UIHostingController(rootView: cellView).view
        
        assertSnapshot(matching: view, as: .image(size: view.intrinsicContentSize), record: false)
    }
}
