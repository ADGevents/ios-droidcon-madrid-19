//
//  Either.swift
//  droidconmadrid19
//
//  Created by vjgarcia on 04/11/2019.
//  Copyright © 2019 vjgarcia. All rights reserved.
//

import Foundation

public enum Either<T, U> {
	case left(T)
	case right(U)
}

// MARK: - Either
extension Either {
	/// Constructs a `Left`.
	///
	/// Suitable for partial application.
	public static func toLeft(_ value: T) -> Either {
		return .left(value)
	}
	
	/// Constructs a `Right`.
	///
	/// Suitable for partial application.
	public static func toRight(_ value: U) -> Either {
		return .right(value)
	}
	
	/// Returns the result of applying `f` to the value of `Left`, or `g` to the value of `Right`.
	public func either<Result>(ifLeft: (T) throws -> Result, ifRight: (U) throws -> Result) rethrows -> Result {
		switch self {
		case let .left(x):
			return try ifLeft(x)
		case let .right(x):
			return try ifRight(x)
		}
	}
}

// MARK: - Either : CustomStringConvertible
extension Either: CustomStringConvertible {
	public var description: String {
		return either(
			ifLeft: { ".Left(\($0))"},
			ifRight: { ".Right(\($0))" })
	}
}


// MARK: - Either : CustomDebugStringConvertible
extension Either: CustomDebugStringConvertible {
	public var debugDescription: String {
		return either(
			ifLeft: { ".Left(\(String(reflecting: $0)))" },
			ifRight: { ".Right(\(String(reflecting: $0)))" })
	}
}

// MARK: - Methods
extension Either {
	/// Maps `Right` values with `transform`, and re-wraps `Left` values.
	public func map<V>(_ transform: (U) -> V) -> Either<T, V> {
		return flatMap { .right(transform($0)) }
	}
	
	/// Returns the result of applying `transform` to `Right` values, or re-wrapping `Left` values.
	public func flatMap<V>(_ transform: (U) -> Either<T, V>) -> Either<T, V> {
		return either(
			ifLeft: Either<T, V>.left,
			ifRight: transform)
	}
	
	/// Maps `Left` values with `transform`, and re-wraps `Right` values.
	public func mapLeft<V>(_ transform: (T) -> V) -> Either<V, U> {
		return flatMapLeft { .left(transform($0)) }
	}
	
	/// Returns the result of applying `transform` to `Left` values, or re-wrapping `Right` values.
	public func flatMapLeft<V>(_ transform: (T) -> Either<V, U>) -> Either<V, U> {
		return either(
			ifLeft: transform,
			ifRight: Either<V, U>.right)
	}
	
	/// Maps `Left` values with `left` & maps `Right` values with `right`.
	public func bimap<V, W>(leftBy lf: (T) -> V, rightBy rf: (U) -> W) -> Either<V, W> {
		return either(
			ifLeft: { .left(lf($0)) },
			ifRight: { .right(rf($0)) })
	}
}

extension Either {
	func rightOrNil() -> U? {
		switch self {
		case let .right(value):
			return value
		default:
			return nil
		}
	}
	
	func leftOrNil() -> T? {
		switch self {
		case let .left(value):
			return value
		default:
			return nil
		}
	}
}
