//  Copyright (c) 2015 Rob Rix. All rights reserved.

/// A multiset of elements and their counts.
public struct Multiset<T: Hashable> {
	// MARK: Properties

	/// True iff `count` is 0.
	public var isEmpty: Bool {
		return values.isEmpty
	}


	// MARK: Private

	/// Constructs a `Multiset` with a dictionary of `values`.
	private init(values: [T: Int]) {
		self.values = values
	}

	/// Counts indexed by value.
	private var values: [T: Int]
}
