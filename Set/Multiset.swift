//  Copyright (c) 2015 Rob Rix. All rights reserved.

/// A multiset of elements and their counts.
public struct Multiset<Element: Hashable>: ExtensibleCollectionType {
	// MARK: Constructors

	/// Constructs a `Set` with the elements of `sequence`.
	public init<S: SequenceType where S.Generator.Element == Element>(_ sequence: S) {
		self.init(values: [:])
		extend(sequence)
	}

	/// Constructs a `Set` from a variadic parameter list.
	public init(_ elements: Element...) {
		self.init(elements)
	}

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

	public typealias Index = MultisetIndex<Element>

	public var startIndex: Index {
		return MultisetIndex(from: values.startIndex, delta: 0, max: count)
	}

	public var endIndex: Index {
		return MultisetIndex(from: values.endIndex, delta: 0, max: count)
	}

	public subscript(index: Index) -> Element {
		let (element, count) = values[index.from]
		if index.delta > (count - 1) {
			return self[MultisetIndex(from: index.from.successor(), delta: index.delta - count, max: self.count)]
		} else if index.delta < -(count - 1) {
			return self[MultisetIndex(from: index.from.predecessor(), delta: index.delta + count, max: self.count)]
		} else {
			return element
		}
	}


	// MARK: ExtensibleCollectionType

	/// In theory, reserve capacity for `n` elements. However, `Dictionary` does not implement `reserveCapacity`, so we just silently ignore it.
	public func reserveCapacity(n: Multiset.Index.Distance) {}

	/// Inserts each element of `sequence` into the receiver.
	public mutating func extend<S: SequenceType where S.Generator.Element == Element>(sequence: S) {
		// Note that this should just be for each in sequence; this is working around a compiler bug.
		for each in SequenceOf<Element>(sequence) {
			insert(each)
		}
	}

	/// Appends `element` onto the `Set`.
	public mutating func append(element: Element) {
		insert(element)
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
