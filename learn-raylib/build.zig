const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const raylib_dep = b.dependency("raylib_zig", .{
        .target = target,
        .optimize = optimize,
    });
    const raylib = raylib_dep.module("raylib");
    const raygui = raylib_dep.module("raygui");
    const raylib_artifact = raylib_dep.artifact("raylib");

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
        .name = "core-01",
        .path = "src/core/01_basic_window.zig",
        .desc = "Core / Basic window",
    },
    .{
        .name = "core-02",
        .path = "src/core/02_basic_screen_manager.zig",
        .desc = "Core / Basic screen manager",
    },
};
