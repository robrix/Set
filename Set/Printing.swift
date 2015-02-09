//  Copyright (c) 2015 Rob Rix. All rights reserved.

/// Describes a sequence as a set.
internal func describe<S: SequenceType>(sequence: S) -> String {
	return wrapDescription(join(", ", lazy(sequence).map(toString)))
}

/// Debug-describes a sequence as a set.
internal func debugDescribe<S: SequenceType>(sequence: S) -> String {
	return wrapDescription(join(", ", lazy(sequence).map(toDebugString)))
}


/// Wraps a string appropriately for formatting as a set.
private func wrapDescription(description: String) -> String {
	return description.isEmpty ?
		"{}"
	:	"{ \(description) }"
}
