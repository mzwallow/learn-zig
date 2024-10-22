const expect = @import("std").testing.expect;
const print = @import("std").debug.print;

const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error{OutOfMemory};

test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try expect(err == FileOpenError.OutOfMemory);
}

test "error union" {
    const maybe_error: AllocationError!u16 = 10;
    const no_error = maybe_error catch 0;

    try expect(@TypeOf(no_error) == u16);
    try expect(no_error == 10);
}

fn failingFunction() error{Oops}!void {
    return error.Oops;
}

test "returning an error" {
    // |err| is called "payload capturing"
    failingFunction() catch |err| {
        try expect(err == error.Oops);
        return;
    };
}

// NOTE:
// `try x` is a shortcut for `x catch |err| return err`,
// and is commonly used where handling an error isn't appropriate.
// Zig's try and catch are unrelated to try-catch in other languages.

fn failFn() error{Oops}!i32 {
    try failingFunction();
    return 12;
}

test "try" {
    const v = failFn() catch |err| {
        try expect(err == error.Oops);
        return;
    };
    try expect(v == 12); // is never reached
}

var problems: u32 = 98;

fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}

test "errdefer" {
    failFnCounter() catch |err| {
        try expect(err == error.Oops);
        try expect(problems == 99);
        return;
    };
}

fn createFile() !void {
    return error.AccessDenied;
}

test "inferred error set" {
    // Type Coercion successfully takes place
    const x: error{AccessDenied}!void = createFile();

    // Zig does not let us ignore error unions via _ = x;
    // We must unwrap it with "try", "catch", or "if" by any means
    _ = x catch {};
}

test "merged error set" {
    const A = error{ NotDir, PathNotFound };
    const B = error{ OutOfMemory, PathNotFound };
    const C = A || B;
    try expect(C == error{ OutOfMemory, NotDir, PathNotFound });
}
