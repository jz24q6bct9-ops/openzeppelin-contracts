// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.1.0) (utils/Panic.sol)

pragma solidity ^0.8.20;

/**
 * @dev Helper library for emitting standardized panic codes.
 *
 * ```solidity
 * contract Example {
 *      using Panic for Panic.Code;
 *
 *      // Use any of the declared internal constants
 *      function foo() { Panic.GENERIC.panic(); }
 *
 *      // Alternatively
 *      function foo() { Panic.panic(Panic.GENERIC); }
 * }
 * ```
 *
 * Follows the list from https://github.com/ethereum/solidity/blob/v0.8.24/libsolutil/ErrorCodes.h[libsolutil].
 *
 * _Available since v5.1._
 */
// slither-disable-next-line unused-state
library Panic {
    /**
     * @dev A panic code is a value that can be used to trigger a panic revert.
     * Using this type allows for expressive syntax like `Panic.GENERIC.panic()`.
     */
    type Code is uint256;

    using {panic} for Code global;

    /// @dev generic / unspecified error
    Code internal constant GENERIC = Code.wrap(0x00);
    /// @dev used by the assert() builtin
    Code internal constant ASSERT = Code.wrap(0x01);
    /// @dev arithmetic underflow or overflow
    Code internal constant UNDER_OVERFLOW = Code.wrap(0x11);
    /// @dev division or modulo by zero
    Code internal constant DIVISION_BY_ZERO = Code.wrap(0x12);
    /// @dev enum conversion error
    Code internal constant ENUM_CONVERSION_ERROR = Code.wrap(0x21);
    /// @dev invalid encoding in storage
    Code internal constant STORAGE_ENCODING_ERROR = Code.wrap(0x22);
    /// @dev empty array pop
    Code internal constant EMPTY_ARRAY_POP = Code.wrap(0x31);
    /// @dev array out of bounds access
    Code internal constant ARRAY_OUT_OF_BOUNDS = Code.wrap(0x32);
    /// @dev resource error (too large allocation or too large array)
    Code internal constant RESOURCE_ERROR = Code.wrap(0x41);
    /// @dev calling invalid internal function
    Code internal constant INVALID_INTERNAL_FUNCTION = Code.wrap(0x51);

    /// @dev Reverts with a panic code. Recommended to use with
    /// the internal constants with predefined codes.
    function panic(Code code) internal pure {
        assembly ("memory-safe") {
            mstore(0x00, 0x4e487b71)
            mstore(0x20, code)
            revert(0x1c, 0x24)
        }
    }

    /**
     * @dev Select a panic code based on a condition.
     * @param condition The condition to evaluate
     * @param a The code to return if condition is true
     * @param b The code to return if condition is false
     * @return The selected code
     */
    function ternary(bool condition, Code a, Code b) internal pure returns (Code) {
        return condition ? a : b;
    }
}
