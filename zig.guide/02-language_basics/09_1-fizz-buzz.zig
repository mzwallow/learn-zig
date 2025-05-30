const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    // return starting();
    return usingSwitch();
}

fn starting() !void {
    const stdout = std.io.getStdOut().writer();
    var count: u8 = 1;
    while (count <= 100) : (count += 1) {
        if (count % 3 == 0 and count % 5 == 0) {
            try stdout.writeAll("Fizz Buzz\n");
        } else if (count % 5 == 0) {
            try stdout.writeAll("Buzz\n");
        } else if (count % 3 == 0) {
            try stdout.writeAll("Fizz\n");
        } else {
            try stdout.print("{}\n", .{count});
        }
    }
}

fn usingSwitch() !void {
    const stdout = std.io.getStdOut().writer();
    var count: u8 = 1;

    while (count <= 100) : (count += 1) {
        const div_3: u2 = @intFromBool(count % 3 == 0);
        const div_5 = @intFromBool(count % 5 == 0);

        // we can use bitwise operations also:
        // div_3 << 1 | div_5
        switch (div_3 * 2 + div_5) {
            0b10 => try stdout.writeAll("Fizz\n"),
            0b11 => try stdout.writeAll("Fizz Buzz\n"),
            0b01 => try stdout.writeAll("Buzz\n"),
            0b00 => try stdout.print("{}\n", .{count}),
        }
    }
}
