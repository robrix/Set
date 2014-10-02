//  Copyright (c) 2014 Rob Rix. All rights reserved.

/// A set of unique elements.
public struct Set<Element : Hashable> {
	var _dictionary: Dictionary<Element, Unit> = [:]
	
	public init<S : SequenceType where S.Generator.Element == Element>(_ sequence: S) {
		extend(sequence)
	}
	
	public init() {}
	
	
	public var count: Int { return _dictionary.count }
	
	public func contains(element: Element) -> Bool {
		return _dictionary[element] != nil
	}
	
	public mutating func insert(element: Element) {
		_dictionary[element] = Unit()
	}
	
	public mutating func remove(element: Element) {
		_dictionary.removeValueForKey(element)
	}
}


/// Sequence conformance.
extension Set : SequenceType {
	public func generate() -> GeneratorOf<Element> {
		var generator = _dictionary.keys.generate()
		return GeneratorOf {
			return generator.next()
		}
	}
}


/// Collection conformance.
///
/// Does not actually conform to Collection because that crashes the compiler.
extension Set {
	typealias IndexType = DictionaryIndex<Element, Unit>
	var startIndex: IndexType { return _dictionary.startIndex }
	var endIndex: IndexType { return _dictionary.endIndex }
	
	subscript(index: IndexType) -> Element {
		return _dictionary[index].0
	}
}

/// ExtensibleCollection conformance.
///
/// Does not actually conform to ExtensibleCollection because that crashes the compiler.
extension Set {
	/// In theory, reserve capacity for \c n elements. However, Dictionary does not implement reserveCapacity(), so we just silently ignore it.
	func reserveCapacity(n: IndexType.Distance) {}
	
	/// Inserts each element of \c sequence into the receiver.
	mutating func extend<S : SequenceType where S.Generator.Element == Element>(sequence: S) {
		// Note that this should just be for each in sequence; this is working around a compiler crasher.
		for each in [Element](sequence) {
			insert(each)
		}
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
	return a._dictionary == b._dictionary
}


/// Set is reducible.
extension Set {
	public func reduce<Into>(initial: Into, combine: (Into, Element) -> Into) -> Into {
		return Swift.reduce(self, initial, combine)
	}
}
