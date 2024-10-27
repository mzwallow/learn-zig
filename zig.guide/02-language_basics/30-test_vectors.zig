const expect = @import("std").testing.expect;

const meta = @import("std").meta;

test "vector add" {
    const x: @Vector(4, f32) = .{ 1, -10, 20, -1 };
    const y: @Vector(4, f32) = .{ 2, 10, 0, 1 };
    const z = x + y;
    try expect(meta.eql(z, @Vector(4, f32){ 3, 0, 20, 0 }));
}

test "vector indexing" {
    const x: @Vector(4, u8) = .{ 255, 0, 255, 0 };
    try expect(x[0] == 255);
}

test "vector * scalar" {
    const x: @Vector(3, f32) = .{ 12.5, 37.5, 2.5 };
    const y = x * @as(@Vector(3, f32), @splat(2));
    try expect(meta.eql(y, @Vector(3, f32){ 25, 75, 5 }));
}

// Vectors do not have a 'len' field like arrays, but may still be looped over.
test "vector looping" {
    const x = @Vector(4, u8){ 255, 0, 255, 0 };
    const sum = blk: {
        var tmp: u10 = 0;
        var i: u8 = 0;
        while (i < 4) : (i += 1) tmp += x[i];
        break :blk tmp;
    };
    try expect(sum == 510);
}

// Vectors coerce to their respective arrays.
// const arr: [4]f32 = @Vector(4, f32){ 1, 2, 3, 4 };

// NOTE: It is worth noting that using explicit vectors may result in
// slower software if you do not make the right decisions -
// the compiler's auto-vectorisation is fairly smart as-is.
