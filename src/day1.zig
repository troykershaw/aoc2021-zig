const ArrayList = @import("std").ArrayList;

fn increases(depths: ArrayList(usize), window_size: usize) usize {
    var count: usize = 0;
    var i: usize = window_size;
    while (i < depths.items.len) : (i += 1) {
        if (depths.items[i] > depths.items[i - window_size]) {
            count += 1;
        }
    }
    return count;
}

const testing = @import("std").testing;
const readUnsigned = @import("read-data.zig").readUnsigned;

test "example data" {
    var depths = ArrayList(usize).init(testing.allocator);
    defer depths.deinit();
    try readUnsigned("./src/data/day1example.txt", &depths);

    try testing.expectEqual(@as(usize, 7), increases(depths, 1)); // part 1
    try testing.expectEqual(@as(usize, 5), increases(depths, 3)); // part 2
}

test "real data" {
    var depths = ArrayList(usize).init(testing.allocator);
    defer depths.deinit();
    try readUnsigned("./src/data/day1.txt", &depths);

    try testing.expectEqual(@as(usize, 1791), increases(depths, 1)); // part 1
    try testing.expectEqual(@as(usize, 1822), increases(depths, 3)); // part 2
}
