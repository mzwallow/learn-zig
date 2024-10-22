const constant: i32 = 5; // signed 32-bit constant
var variable: u32 = 5000; // unsigned 32-bit variable

// @as performs an explicit type coercion
const inferred_constant = @as(i32, 5);
var inferred_variable = @as(u32, 5000);

// Both const and var must have a value, otherwise `undefined` can be used which
// coerces to any type.
const a: i32 = undefined;
const b: u32 = undefined;

// NOTE: Where possible, `const` values are preferred over `var` values.
