class Chat {
  final String name;
  final String message;
  final String time;
  final int unreadCount;

  Chat({
    required this.name,
    required this.message,
    required this.time,
    this.unreadCount = 0,
  });

  // Factory constructor to create a Chat object from a map (for potential API usage)
  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      name: map['name'],
      message: map['message'],
      time: map['time'],
      unreadCount: map['unreadCount'] ?? 0,
    );
  }

  // Method to convert Chat object to a map (for potential API usage)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'message': message,
      'time': time,
      'unreadCount': unreadCount,
    };
  }
}
