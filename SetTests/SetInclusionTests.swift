//  Copyright (c) 2014 Rob Rix. All rights reserved.

import XCTest
import Set

class SetInclusionTests: XCTestCase {
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
}
