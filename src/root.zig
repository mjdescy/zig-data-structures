const std = @import("std");

pub const Node = struct {
    string: []const u8,
    number: i32,
    next: ?*Node = null,
};

test "linked list traversal prints node strings" {
    var third = Node{
        .string = "third",
        .number = 3,
    };
    var second = Node{
        .string = "second",
        .number = 2,
        .next = &third,
    };
    var first = Node{
        .string = "first",
        .number = 1,
        .next = &second,
    };

    var current: ?*const Node = &first;
    var node_count: usize = 0;
    while (current) |node| {
        std.debug.print("{s}\n", .{node.string});
        node_count += 1;
        current = node.next;
    }

    try std.testing.expectEqual(@as(usize, 3), node_count);
}
