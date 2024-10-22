const expect = @import("std").testing.expect;
const stdout = @import("std").io.getStdOut().writer();

fn total(values: []const u8) usize {
    var sum: usize = 0;
    for (values) |v| sum += v;
    return sum;
}

test "slices" {
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    const slice = array[0..3];
    try expect(total(slice) == 6);
}

test "slices 2" {
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    const slice = array[0..3];
    try expect(@TypeOf(slice) == *const [3]u8);

    // var s = array[0..3];
    // _ = &s;
    //
    // try stdout.print("{}\n", .{@TypeOf(array)});
    // try stdout.print("{}\n", .{@TypeOf(slice)});
    // try stdout.print("{}\n", .{@TypeOf(s)});
}

test "slices 3" {
    const array = [_]u8{ 1, 2, 3, 4, 5 };
    const slice = array[0..];
    _ = slice;
}
