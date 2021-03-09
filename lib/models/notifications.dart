class Notification {
  int id;
  int userId;
  int orderId;
  String message;
  String status;
  String createdAt;
  Null imageUser;
  String nameUser;
  int totalOrder;

  Notification(
      {this.id,
        this.userId,
        this.orderId,
        this.message,
        this.status,
        this.createdAt,
        this.imageUser,
        this.nameUser,
        this.totalOrder});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderId = json['order_id'];
    message = json['message'];
    status = json['status'];
    createdAt = json['created_at'];
    imageUser = json['image_user'];
    nameUser = json['name_user'];
    totalOrder = json['total_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['order_id'] = this.orderId;
    data['message'] = this.message;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['image_user'] = this.imageUser;
    data['name_user'] = this.nameUser;
    data['total_order'] = this.totalOrder;
    return data;
  }
}