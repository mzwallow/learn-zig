const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const a = [5]u8{ 'h', 'e', 'l', 'l', 'o' };
    const b = [_]u8{ 'w', 'o', 'r', 'l', 'd' }; // Use `_` to infer the size

    print("a: {s}\tlen: {d}\n", .{ a, a.len });
    print("b: {s}\n", .{b});
}
