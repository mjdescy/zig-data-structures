const std = @import("std");

pub fn LinkedList(comptime T: type) type {
    return struct {
        pub const Node = struct {
            string: []const u8,
            value: T,
            next: ?*Node = null,
        };
    };
}

test "linked list traversal prints node strings" {
    var third = LinkedList(i32).Node{
        .string = "third",
        .value = 3,
    };
    var second = LinkedList(i32).Node{
        .string = "second",
        .value = 2,
        .next = &third,
    };
    var first = LinkedList(i32).Node{
        .string = "first",
        .value = 1,
        .next = &second,
    };

    var current: ?*const LinkedList(i32).Node = &first;
    var node_count: usize = 0;
    while (current) |node| {
        std.debug.print("{s}\n", .{node.string});
        node_count += 1;
        current = node.next;
    }

    try std.testing.expectEqual(@as(usize, 3), node_count);
}
