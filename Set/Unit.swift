//  Copyright (c) 2014 Rob Rix. All rights reserved.

/// A singleton type.
struct Unit {}


/// Unit is Equatable.
extension Unit : Equatable {}

func == (a: Unit, b: Unit) -> Bool { return true }
