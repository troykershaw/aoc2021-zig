const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const read_data_tests = b.addTest("src/read-data.zig");
    read_data_tests.setBuildMode(mode);

    const day1_tests = b.addTest("src/day1.zig");
    day1_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&read_data_tests.step);
    test_step.dependOn(&day1_tests.step);
}
