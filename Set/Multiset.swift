//  Copyright (c) 2015 Rob Rix. All rights reserved.

/// A multiset of elements and their counts.
public struct Multiset<Element: Hashable>: SequenceType, CollectionType {
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

	/// Retrieve an arbitrary element & insert with empty subscript.
	public subscript(v: ()) -> Element {
		get { return values[values.startIndex].0 }
		set { insert(newValue) }
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


	// MARK: CollectionType

	public typealias Index = DictionaryIndex<Element, Int>

	public var startIndex: Index {
		return values.startIndex
	}

	public var endIndex: Index {
		return values.endIndex
	}

	public subscript(index: Index) -> Element {
		return values[index].0
	}


	// MARK: Private

	/// Constructs a `Multiset` with a dictionary of `values`.
	private init(values: [Element: Int]) {
		self.values = values
	}

	/// Counts indexed by value.
	private var values: [Element: Int]
}


/// The index for values of a multiset.
public struct MultisetIndex<Element: Hashable>: BidirectionalIndexType, Comparable {
	// MARK: BidirectionalIndexType

	public func predecessor() -> MultisetIndex {
		return MultisetIndex(from: from, delta: delta - 1, max: max)
	}

	public func successor() -> MultisetIndex {
		return MultisetIndex(from: from, delta: delta + 1, max: max)
	}


	// MARK: Private

	private let from: DictionaryIndex<Element, Int>
	private let delta: Int
	private let max: Int
}


// MARK: Equatable

public func == <Element: Hashable> (left: MultisetIndex<Element>, right: MultisetIndex<Element>) -> Bool {
	if left.from == right.from {
		return left.delta == right.delta && left.max == right.max
	} else {
		return left.max == right.max && abs(left.delta - right.delta) == left.max
	}
}

// MARK: Comparable

public func < <Element: Hashable> (left: MultisetIndex<Element>, right: MultisetIndex<Element>) -> Bool {
	if left.from == right.from {
		return left.delta < right.delta
	} else if left.from < right.from {
		return (left.delta - right.delta) < left.max
	}
	return false
}
