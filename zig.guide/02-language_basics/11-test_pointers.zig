const expect = @import("std").testing.expect;

fn increment(num: *u8) void {
    num.* += 1;
}

test "pointers" {
    var x: u8 = 1;
    increment(&x);
    try expect(x == 2);
}

// NOTE: Normal pointers in Zig cannot have 0 or null as a value.
// test "naughty pointer" {
//     var x: u16 = 0;
//     var y: *u8 = @ptrFromInt(x);
//     _ = &x;
//     _ = &y;
// }

// test "const pointer" {
//     const x: u8 = 1;
//     var y = &x;
//     y.* += 1;
//     _ = &y;
// }

// NOTE: A *T coerces to a *const T.
