//  Copyright (c) 2014 Rob Rix. All rights reserved.

struct Set<Element : Hashable> {
	var _dictionary: Dictionary<Element, Void> = [:]
}

extension Set {
	func contains(element: Element) -> Bool {
		return _dictionary[element].getLogicValue()
	}
}
