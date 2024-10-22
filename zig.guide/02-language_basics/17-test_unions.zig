const expect = @import("std").testing.expect;

// const Result = union {
//     int: i64,
//     float: f64,
//     bool: bool,
// };
//
// test "simple union" {
//     var result = Result{ .int = 1234 };
//     result.float = 12.34;
// }

const Tag = enum { a, b, c };

const Tagged = union(Tag) { a: u8, b: f32, c: bool };

test "switch on tagged union" {
    var value = Tagged{ .b = 1.5 };
    switch (value) {
        .a => |*byte| byte.* += 1,
        .b => |*float| float.* *= 2,
        .c => |*b| b.* = !b.*,
    }
    try expect(value.b == 3);
}

// The tag type of a tagged union can also be inferred. This is equivalent to
// the Tagged type above.
//
// const Tagged = union(enum) { a: u8, b: f32, c: bool };

// 'void' member types can have their type omitted from the syntax.
// Here, none is of type 'void'.
const Tagged2 = union(enum) { a: u8, b: f32, c: bool, none };
