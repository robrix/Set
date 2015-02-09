//  Copyright (c) 2015 Rob Rix. All rights reserved.

import Set
import XCTest

final class MultisetAlgebraTests: XCTestCase {
	func testUnionOfMultisetsSumsMultiplicities() {
		XCTAssertEqual((Multiset(1, 2, 3) + Multiset(1)).count(1), 2)
	}
}
