//  Copyright (c) 2015 Rob Rix. All rights reserved.

public struct PredicateSet<Element: Hashable> {
	public let predicate: Element -> Bool
	
	public init() {
		predicate = { _ in false }
	}
	
	public init(_ predicate: Element -> Bool) {
		self.predicate = predicate
	}
	
	public init<T>(_ predicate: Element -> T?) {
		self.predicate = { element in
			return predicate(element) != nil
		}
	}
	
	public init(_ set: Set<Element>) {
		predicate = { set.contains($0) }
	}
	
	public init(_ set: Multiset<Element>) {
		predicate = { set.contains($0) }
	}

	public func contains(element: Element) -> Bool {
		return predicate(element)
	}
	
	public func union(set: PredicateSet) -> PredicateSet {
		return PredicateSet { self.predicate($0) || set.contains($0) }
	}
	
	public func intersection(set: PredicateSet) -> PredicateSet {
		return PredicateSet { self.predicate($0) && set.contains($0) }
	}
	
	public func complement(set: PredicateSet) -> PredicateSet {
		return PredicateSet { self.predicate($0) && !set.contains($0) }
	}
	
	public func difference(set: PredicateSet) -> PredicateSet {
		return PredicateSet { !(self.predicate($0) && set.contains($0)) }
	}
}

public func +<T>(lhs: PredicateSet<T>, rhs: PredicateSet<T>) -> PredicateSet<T> {
	return lhs.union(rhs)
}

public func -<T>(lhs: PredicateSet<T>, rhs: PredicateSet<T>) -> PredicateSet<T> {
	return lhs.difference(rhs)
}

private func isInt(number: Float) -> Bool {
	return floor(number) == number
}

public let Q = PredicateSet { $0 as Float }
public let Z = Q.intersection(PredicateSet { isInt($0) })
public let N = Z.intersection(PredicateSet { $0 > 0 })

// MARK: - Imports
import Darwin
