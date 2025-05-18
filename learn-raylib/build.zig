const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const raylib_dep = b.dependency("raylib_zig", .{
        .target = target,
        .optimize = optimize,
    });
    const raylib = raylib_dep.module("raylib"); // main raylib module
    const raygui = raylib_dep.module("raygui"); // raygui module
    const raylib_artifact = raylib_dep.artifact("raylib"); // raylib c library

    // const exe = b.addExecutable(.{
    //     .name = "learn-raylib",
    //     .root_source_file = null,
    //     .target = target,
    //     .optimize = optimize,
    // });
    // exe.linkLibrary(raylib_artifact);
    // exe.root_module.addImport("raylib", raylib);
    // exe.root_module.addImport("raygui", raygui);

    for (examples) |ex| {
        const ex_exe = b.addExecutable(.{
            .name = ex.name,
            .root_source_file = b.path(ex.path),
            .target = target,
            .optimize = optimize,
        });
        ex_exe.linkLibrary(raylib_artifact);
        ex_exe.root_module.addImport("raylib", raylib);
        ex_exe.root_module.addImport("raygui", raygui);

        const run_exe = b.addRunArtifact(ex_exe);

        const run_step = b.step(ex.name, ex.desc);
        run_step.dependOn(&run_exe.step);
    }
}

const Example = struct {
    name: []const u8,
    path: []const u8,
    desc: []const u8,
};

const examples = [_]Example{
    .{
        .name = "basic_window",
        .path = "src/core/basic_window.zig",
        .desc = "Core / Basic window",
    },
    .{
        .name = "basic_screen_manager",
        .path = "src/core/basic_screen_manager.zig",
        .desc = "Core / Basic screen manager",
    },
};
