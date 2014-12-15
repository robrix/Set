//  Copyright (c) 2014 Rob Rix. All rights reserved.

import XCTest
import Set

class SetTests: XCTestCase {
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
	}

	func testIntersectionAssignment() {
		var set = Set(1, 2, 3)
		set &= Set(2, 3, 4)

		XCTAssert(set == Set(2, 3))
	}
	
	func testDifference() {
		XCTAssert(Set(1, 2, 3) - Set(2, 3, 4) == Set(1))
	}

	func testDifferenceAssignment() {
		var set = Set(1, 2, 3)
		set -= Set(2, 3, 4)

		XCTAssert(set == Set(1))
	}

	func testSubset() {
		XCTAssert(Set(1).subset(Set(1, 2, 3)))
	}

	func testStrictSubset() {
		XCTAssert(Set(1).strictSubset(Set(1, 2)))
		XCTAssertFalse(Set(1).strictSubset(Set(1)))
	}

	func testSubsetIncludesSelf() {
		XCTAssert(Set(1, 2, 3).subset(Set(1, 2, 3)))
	}

	func testStrictSupersetIsNotSubset() {
		XCTAssertFalse(Set(1, 2, 3, 4).subset(Set(1, 2, 3)))
	}

	func testEmptySetIsAlwaysSubset() {
		XCTAssert(Set().subset(Set<Int>()))
		XCTAssert(Set().subset(Set(1, 2, 3)))
	}

	func testSuperset() {
		XCTAssert(Set(1, 2, 3).superset(Set(1)))
	}

	func testStrictSuperset() {
		XCTAssert(Set(1, 2).strictSuperset(Set(1)))
		XCTAssertFalse(Set(1).strictSuperset(Set(1)))
	}

	func testSupersetIncludesSelf() {
		XCTAssert(Set(1, 2, 3).superset(Set(1, 2, 3)))
	}

	func testStrictSubsetIsNotSuperset() {
		XCTAssertFalse(Set(1, 2, 3).superset(Set(1, 2, 3, 4)))
	}

	func testAlwaysSupersetOfEmptySet() {
		XCTAssert(Set<Int>().superset(Set()))
		XCTAssert(Set(1, 2, 3).superset(Set()))
	}

	func testMap() {
		XCTAssert(Set(1, 2, 3).map(toString) == Set("1", "2", "3"))
	}

	func testFlatMapReturnsTheUnionOfAllResultingSets() {
		XCTAssert(Set(1, 2).flatMap { [$0, $0 * 2] } == Set(1, 2, 4))
	}
}
