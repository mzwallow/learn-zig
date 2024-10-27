const expect = @import("std").testing.expect;

// 'inline' loops are unrolled, and allow some things to happen that only work at compile time.
test "inline for" {
    const types = [_]type{ i32, f32, u8, bool };
    var sum: usize = 0;
    inline for (types) |T| sum += @sizeOf(T);
    try expect(sum == 10);
}
