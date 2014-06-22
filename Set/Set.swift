//  Copyright (c) 2014 Rob Rix. All rights reserved.

struct Set<Element : Hashable> {
	var _dictionary: Dictionary<Element, Void> = [:]
}

extension Set {
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

extension Set : Sequence {
	func generate() -> MapSequenceGenerator<Dictionary<Element, Void>.GeneratorType, Element> {
		return _dictionary.keys.generate()
	}
}
