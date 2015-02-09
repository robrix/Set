//  Copyright (c) 2015 Rob Rix. All rights reserved.

import XCTest
import Set

final class MultisetSequenceTests: XCTestCase {
	func testGeneratorProducesEveryElement() {
		var multiset = Multiset<Int>()
		multiset.insert(0)
		multiset.insert(1)
		multiset.insert(2)
		XCTAssertEqual(sorted(map(multiset) { $0 }), [ 0, 1, 2 ])
	}

	func testGeneratorProducesElementsByMultiplicity() {
		var multiset = Multiset<Int>()
		multiset.insert(1)
		multiset.insert(1)
		multiset.insert(1)
		multiset.insert(2)
		multiset.insert(2)
		multiset.insert(3)
		XCTAssertEqual(reduce(multiset, 0, +), 10)
	}
}
