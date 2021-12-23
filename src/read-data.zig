const fs = @import("std").fs;
const io = @import("std").io;
const fmt = @import("std").fmt;
const ArrayList = @import("std").ArrayList;

pub fn readUnsigned(path: []const u8, buffer: *ArrayList(usize)) !void {
    const file = try fs.cwd().openFile(path, .{});
    defer file.close();

    var buf_reader = io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader(); 

    var buf: [1024]u8 = undefined;
    while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        try buffer.append(try fmt.parseUnsigned(usize, line, 10));
    }
}

const testing = @import("std").testing;
const eql = @import("std").mem.eql;

test "reads data as unsigned" {
    var data = ArrayList(usize).init(testing.allocator);
    defer data.deinit();

    try readUnsigned("./src/data/day1.txt", &data);

    try testing.expectEqual(@as(usize, 2000), data.items.len);
    try testing.expectEqual(@as(usize, 198), data.items[0]);
    try testing.expectEqual(@as(usize, 10930), data.items[data.items.len - 1]);
}