const std = @import("std");
const expect = std.testing.expect;
const eql = std.mem.eql;

test "sorting" {
    var data = [_]u8{ 10, 240, 0, 0, 10, 5 };
    std.mem.sort(u8, &data, {}, comptime std.sort.asc(u8));
    try expect(eql(u8, &data, &[_]u8{ 0, 0, 5, 10, 10, 240 }));
    std.mem.sort(u8, &data, {}, comptime std.sort.desc(u8));
    try expect(eql(u8, &data, &[_]u8{ 240, 10, 10, 5, 0, 0 }));
}

// NOTE: 'std.sort.asc' and '.desc' create a comparison function for the given
// type at comptime; if non-numerical types should be sorted,
// the user must provide their own comparison function.
//
// NOTE: 'std.mem.sort' has a best case of O(n), and an average and worst case of O(n*log(n)).
