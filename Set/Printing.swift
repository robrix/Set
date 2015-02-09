//  Copyright (c) 2015 Rob Rix. All rights reserved.

/// Describes a sequence as a set.
internal func describe<S: SequenceType>(sequence: S) -> String {
	let description = join(", ", lazy(sequence).map(toString))
	return description.isEmpty ?
		"{}"
	:	"{ \(description) }"
}

/// Debug-describes a sequence as a set.
internal func debugDescribe<S: SequenceType>(sequence: S) -> String {
	let description = join(", ", lazy(sequence).map(toDebugString))
	return description.isEmpty ?
		"{}"
	:	"{ \(description) }"
}
