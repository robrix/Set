//  Copyright (c) 2015 Rob Rix. All rights reserved.

/// A multiset of elements and their counts.
public struct Multiset<Element: Hashable>: SequenceType {
	// MARK: Constructors

	/// Constructs the empty `Multiset`.
	public init() {
		self.init(values: [:])
	}

	/// Constructs an empty `Multiset` with a hint as to the capacity it should allocate.
	public init(minimumCapacity: Int) {
		self.init(values: [Element: Int](minimumCapacity: minimumCapacity))
	}


	// MARK: Properties

	/// The number of entries in the multiset.
	public var count: Int {
		return reduce(lazy(values).map { $0.1 }, 0, +)
	}

	/// True iff `count` is 0.
	public var isEmpty: Bool {
		return values.isEmpty
	}


	// MARK: Primitive operations

	/// True iff `element` is in the receiver, as defined by its hash and equality.
	public func contains(element: Element) -> Bool {
		return values[element] != nil
	}

	/// Inserts `element` into the receiver.
	public mutating func insert(element: Element) {
		values[element] = (values[element] ?? 0) + 1
	}

	/// Removes `element` from the receiver.
	public mutating func remove(element: Element) {
		if let value = values[element] {
			if value > 0 {
				values[element] = value - 1
			} else {
				values.removeValueForKey(element)
			}
		}
	}

	/// Removes all elements from the reeiver.
	public mutating func removeAll() {
		values = [:]
	}


	// MARK: SequenceType

	public func generate() -> GeneratorOf<Element> {
		var generator = values.generate()
		let next = { generator.next() }
		var current: (element: Element?, count: Int) = (nil, 0)
		return GeneratorOf {
			while current.count <= 0 {
				if let (element, count) = next() {
					current = (element, count)
					break
				}
				else { return nil }
			}
			--current.count
			return current.element
		}
	}


	// MARK: Private

	/// Constructs a `Multiset` with a dictionary of `values`.
	private init(values: [Element: Int]) {
		self.values = values
	}

	/// Counts indexed by value.
	private var values: [Element: Int]
}
