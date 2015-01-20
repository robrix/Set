//  Copyright (c) 2014 Rob Rix. All rights reserved.

import XCTest
import Set

class SetOperationTests: XCTestCase {
	func testUnionAddsElementsFromBothOperands() {
		XCTAssert(Set(1, 2, 3, 4) + Set(3, 4, 5) == Set(1, 2, 3, 4, 5))
	}
	
	func testUnionAssignmentModifiesInPlace() {
		var c: Set<Int> = [1, 2, 3]
		c += Set(3, 4, 5)
		
		XCTAssert(c == Set(1, 2, 3, 4, 5))
	}

	func testIntersection() {
		XCTAssert(Set(1, 2, 3) & Set(2, 3, 4) == Set(2, 3))
		XCTAssert(Set(2, 3) & Set(1, 2, 3, 4) == Set(2, 3))
		XCTAssert(Set(1, 2, 3, 4) & Set(2, 3) == Set(2, 3))
	}

	func testIntersectionAssignment() {
		var set = Set(1, 2, 3)
		set &= Set(2, 3, 4)

		XCTAssert(set == Set(2, 3))
	}
	
	func testComplement() {
		XCTAssert(Set(1, 2, 3) - Set(2, 3, 4) == Set(1))
	}

	func testComplementAssignment() {
		var set = Set(1, 2, 3)
		set -= Set(2, 3, 4)

		XCTAssert(set == Set(1))
	}
}
