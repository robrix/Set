//  Copyright (c) 2015 Rob Rix. All rights reserved.

import Set
import XCTest

final class MultisetCollectionTests: XCTestCase {
	func testIndexesElementsByMultiplicity() {
		var multiset = Multiset<Int>()
		multiset.insert(1)
		multiset.insert(1)
		multiset.insert(1)
		multiset.insert(2)
		multiset.insert(2)
		multiset.insert(3)
		XCTAssertEqual(map(multiset) { _ in () }.count, 6)
	}
}
