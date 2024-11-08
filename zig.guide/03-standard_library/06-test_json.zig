const std = @import("std");
const expect = std.testing.expect;
const test_allocator = std.testing.allocator;
const eql = std.mem.eql;

const Place = struct { lat: f32, lon: f32 };

test "json parse" {
    const parsed = try std.json.parseFromSlice(
        Place,
        test_allocator,
        \\{ "lat": 40.684540, "lon": -74.401422 }
    ,
        .{},
    );
    defer parsed.deinit();

    const place = parsed.value;

    try expect(place.lat == 40.684540);
    try expect(place.lon == -74.401422);
}

test "json stringify" {
    const x = Place{
        .lat = 51.997664,
        .lon = -0.740687,
    };

    var buf: [100]u8 = undefined;
    var fba = std.heap.FixedBufferAllocator.init(&buf);
    var string = std.ArrayList(u8).init(fba.allocator());
    try std.json.stringify(x, .{}, string.writer());

    try expect(eql(u8, string.items,
        \\{"lat":5.199766540527344e1,"lon":-7.406870126724243e-1}
    ));
}

test "json parse with strings" {
    const User = struct { name: []u8, age: u16 };

    const parsed = try std.json.parseFromSlice(User, test_allocator,
        \\{ "name": "Joe", "age": 25 }
    , .{});
    defer parsed.deinit();

    const user = parsed.value;

    try expect(eql(u8, user.name, "Joe"));
    try expect(user.age == 25);
}
