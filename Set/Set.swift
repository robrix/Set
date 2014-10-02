//  Copyright (c) 2014 Rob Rix. All rights reserved.

/// A set of unique elements.
public struct Set<Element : Hashable> {
	public init<S : SequenceType where S.Generator.Element == Element>(_ sequence: S) {
		extend(sequence)
	}
	
	public init() {}
	
	
	public var count: Int { return values.count }
	
	public func contains(element: Element) -> Bool {
		return values[element] != nil
	}
	
	public mutating func insert(element: Element) {
		values[element] = Unit()
	}
	
	public mutating func remove(element: Element) {
		values.removeValueForKey(element)
	}

	private var values: Dictionary<Element, Unit> = [:]
}


/// SequenceType conformance.
extension Set : SequenceType {
	public func generate() -> GeneratorOf<Element> {
		var generator = values.keys.generate()
		return GeneratorOf {
			return generator.next()
		}
	}
}


/// CollectionType conformance.
extension Set : CollectionType {
	public typealias IndexType = DictionaryIndex<Element, Unit>
	public var startIndex: IndexType { return values.startIndex }
	public var endIndex: IndexType { return values.endIndex }
	
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


/// Creates and returns the union of \c set and \c sequence.
public func + <S : SequenceType> (set: Set<S.Generator.Element>, sequence: S) -> Set<S.Generator.Element> {
	var union = Set(set)
	union += sequence
	return union
}


/// Extends /c set with the elements of /c sequence.
public func += <S : SequenceType> (inout set: Set<S.Generator.Element>, sequence: S) {
	set.extend(sequence)
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
