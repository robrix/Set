//  Copyright (c) 2015 Rob Rix. All rights reserved.

/// A multiset of elements and their counts.
public struct Multiset<T: Hashable> {
	/// Counts indexed by value.
	private var values: [T: Int]
}
