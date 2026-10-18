const std = @import("std");
const Io = std.Io;

const zig_data_structures = @import("zig_data_structures");

const Entry = struct {
    key: []const u8,
    value: i32,
};

pub fn main(init: std.process.Init) !void {
    var third = zig_data_structures.Node{
        .string = "third",
        .number = 3,
    };
    var second = zig_data_structures.Node{
        .string = "second",
        .number = 2,
        .next = &third,
    };
    var first = zig_data_structures.Node{
        .string = "first",
        .number = 1,
        .next = &second,
    };

    var stdout_buffer: [1024]u8 = undefined;
    var stdout_file_writer: Io.File.Writer = .init(.stdout(), init.io, &stdout_buffer);
    const stdout_writer = &stdout_file_writer.interface;

    try stdout_writer.writeAll("[");
    var current: ?*const zig_data_structures.Node = &first;
    var is_first = true;
    while (current) |node| {
        if (is_first) {
            is_first = false;
        } else {
            try stdout_writer.writeAll(",");
        }
        try std.json.Stringify.value(
            Entry{
                .key = node.string,
                .value = node.number,
            },
            .{},
            stdout_writer,
        );
        current = node.next;
    }
    try stdout_writer.writeAll("]\n");
    try stdout_writer.flush();
}
