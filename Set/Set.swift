//  Copyright (c) 2014 Rob Rix. All rights reserved.

/// A set of unique elements.
struct Set<Element : Hashable> {
	var _dictionary: Dictionary<Element, Void> = [:]
	
	init<S : Sequence where S.GeneratorType.Element == Element>(_ sequence: S) {
		extend(sequence)
	}
	
	init() {}
	
	
	var count: Int { return _dictionary.count }
	
	func contains(element: Element) -> Bool {
		return _dictionary[element].getLogicValue()
	}
	
	mutating func insert(element: Element) {
		_dictionary[element] = ()
	}
	
	mutating func remove(element: Element) {
		_dictionary.removeValueForKey(element)
	}
}


/// Sequence conformance.
extension Set : Sequence {
	func generate() -> MapSequenceGenerator<Dictionary<Element, Void>.GeneratorType, Element> {
		return _dictionary.keys.generate()
	}
}


/// Collection conformance.
///
/// Does not actually conform to Collection because that crashes the compiler.
extension Set {
	typealias IndexType = DictionaryIndex<Element, Void>
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
	func reserveCapacity(n: IndexType.DistanceType) {}
	
	/// Inserts each element of \c sequence into the receiver.
	mutating func extend<S : Sequence where S.GeneratorType.Element == Element>(sequence: S) {
		// Note that this should just be for each in sequence; this is working around a compiler crasher.
		for each in Element[](sequence) {
			insert(each)
		}
	}
}


/// Creates and returns the union of \c set and \c sequence.
func + <S : Sequence> (set: Set<S.GeneratorType.Element>, sequence: S) -> Set<S.GeneratorType.Element> {
	var union = Set(set)
	union += sequence
	return union
}


/// Extends /c set with the elements of /c sequence.
@assignment func += <S : Sequence> (inout set: Set<S.GeneratorType.Element>, sequence: S) {
	set.extend(sequence)
}


/// ArrayLiteralConvertible conformance.
extension Set : ArrayLiteralConvertible {
	static func convertFromArrayLiteral(elements: Element...) -> Set<Element> {
		return Set(elements)
	}
}
