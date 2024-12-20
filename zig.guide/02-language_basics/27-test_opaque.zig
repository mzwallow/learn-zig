const expect = @import("std").testing.expect;

// const Window = opaque {};
// const Button = opaque {};
//
// extern fn show_window(*Window) callconv(.C) void;
//
// test "opaque" {
//     var main_window: *Window = undefined;
//     show_window(main_window);
//     _ = &main_window;
//
//     var ok_button: *Button = undefined;
//     show_window(ok_button);
//     _ = &ok_button;
// }

const Window = opaque {
    fn show(self: *Window) void {
        show_window(self);
    }
};

extern fn show_window(*Window) callconv(.C) void;

test "opaque with declarations" {
    var main_window: *Window = undefined;
    main_window.show();
}
