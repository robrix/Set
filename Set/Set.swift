//  Copyright (c) 2014 Rob Rix. All rights reserved.

/// A set of unique elements.
public struct Set<Element : Hashable> {
	public init<S : SequenceType where S.Generator.Element == Element>(_ sequence: S) {
		self.values = [:]
		extend(sequence)
	}
	
	public init() {
		self.values = [:]
	}
	
	public init(minimumCapacity: Int) {
		self.values = [Element:Unit](minimumCapacity: minimumCapacity)
	}

	/// The number of entries in the set.
	public var count: Int { return values.count }

	/// True iff `count == 0`
	public var isEmpty: Bool {
		return self.values.isEmpty
	}

	public func contains(element: Element) -> Bool {
		return values[element] != nil
	}
	
	public mutating func insert(element: Element) {
		values[element] = Unit()
	}
	
	public mutating func remove(element: Element) {
		values.removeValueForKey(element)
	}

	private var values: [Element:Unit]
}


/// SequenceType conformance.
extension Set : SequenceType {
	public func generate() -> GeneratorOf<Element> {
		return GeneratorOf(values.keys.generate())
	}
}


/// CollectionType conformance.
extension Set : CollectionType {
	public typealias IndexType = DictionaryIndex<Element, Unit>
	public var startIndex: IndexType { return values.startIndex }
	public var endIndex: IndexType { return values.endIndex }
	
	public subscript(v: ()) -> Element {
	get { return values[values.startIndex].0 }
	set { insert(newValue) }
	}
	
	public subscript(index: IndexType) -> Element {
		return values[index].0
	}
}

/// ExtensibleCollectionType conformance.
extension Set : ExtensibleCollectionType {
	/// In theory, reserve capacity for \c n elements. However, Dictionary does not implement reserveCapacity(), so we just silently ignore it.
	public func reserveCapacity(n: IndexType.Distance) {}
	
	/// Inserts each element of \c sequence into the receiver.
	public mutating func extend<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
		// Note that this should just be for each in sequence; this is working around a compiler crasher.
		for each in [Element](sequence) {
			insert(each)
		}
	}

	public mutating func append(element: Element) {
		insert(element)
	}
}


/// Set operations (union, intersection, difference).
extension Set {
	/// Returns the union of \c self and \c set.
	public func union(set: Set) -> Set {
		return self + set
	}

	/// Returns the intersection of \c self and \c other.
	public func intersection(other: Set) -> Set {
		if self.count <= other.count {
			return Set(filter(self) { other.contains($0) })
		} else {
			return Set(filter(other) { self.contains($0) })
		}
	}

	/// Returns a new set with all elements from \c self which are not contained in \c other.
	public func difference(other: Set) -> Set {
		return Set(filter(self) { !other.contains($0) })
	}
}

/// Higher-order functions.
extension Set {
	/// Returns a new set with the result of applying \c transform to each element.
	public func map<Result>(transform: Element -> Result) -> Set<Result> {
		return flatMap { [transform($0)] }
	}

	/// Apples \c transform to each element and returns a new set which is the union of each resulting set.
	public func flatMap<Result, S: SequenceType where S.Generator.Element == Result>(transform: Element -> S) -> Set<Result> {
		return reduce(Set<Result>()) { $0 + transform($1) }
	}
}

/// Extends \c set with the elements of \c sequence.
public func += <S : SequenceType> (inout set: Set<S.Generator.Element>, sequence: S) {
	set.extend(sequence)
}

/// Returns a new set with all elements from \c set which are not contained in \c other.
public func - <Element> (set: Set<Element>, other: Set<Element>) -> Set<Element> {
	return set.difference(other)
}

/// Removes all elements in \c other from \c set.
public func -= <Element> (inout set: Set<Element>, other: Set<Element>) {
	for element in other {
		set.remove(element)
	}
}

/// Intersects with \c set with \c other.
public func &= <Element> (inout set: Set<Element>, other: Set<Element>) {
	for element in set {
		if !other.contains(element) {
			set.remove(element)
		}
	}
}

/// Returns the intersection of \c set and \c other.
public func & <Element> (set: Set<Element>, other: Set<Element>) -> Set<Element> {
	return set.intersection(other)
}

/// ArrayLiteralConvertible conformance.
extension Set : ArrayLiteralConvertible {
	public init(arrayLiteral elements: Element...) {
		self.init(elements)
	}
}


/// Defines equality for sets of equatable elements.
public func == <Element : Hashable> (a: Set<Element>, b: Set<Element>) -> Bool {
	return a.values == b.values
}


/// Set is reducible.
extension Set {
	public func reduce<Into>(initial: Into, combine: (Into, Element) -> Into) -> Into {
		return Swift.reduce(self, initial, combine)
	}
}


/// Printable conformance.
extension Set : Printable {
	public var description: String {
		if self.count == 0 { return "{}" }
		
		let joined = join(", ", map(toString))
		return "{ \(joined) }"
	}
}


/// Hashable conformance.
///
/// This hash function has not been proven in this usage, but is based on Bob Jenkins’ one-at-a-time hash.
extension Set : Hashable {
	public var hashValue: Int {
		var h = reduce(0) { into, each in
			var h = into + each.hashValue
			h += (h << 10)
			h ^= (h >> 6)
			return h
		}
		h += (h << 3)
		h ^= (h >> 11)
		h += (h << 15)
		return h
	}
}
