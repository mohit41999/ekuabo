class TransactionBean {
  bool status;
  String message;
  List<TransactionDataBean> data;

  TransactionBean({this.status, this.message, this.data});

  TransactionBean.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<TransactionDataBean>();
      json['data'].forEach((v) {
        data.add(new TransactionDataBean.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TransactionDataBean {
  String transactionId;
  String transactionDate;
  String amount;
  String paymentStatus;

  TransactionDataBean(
      {this.transactionId,
        this.transactionDate,
        this.amount,
        this.paymentStatus});

  TransactionDataBean.fromJson(Map<String, dynamic> json) {
    transactionId = json['transaction_id'];
    transactionDate = json['transaction_date'];
    amount = json['amount'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transaction_id'] = this.transactionId;
    data['transaction_date'] = this.transactionDate;
    data['amount'] = this.amount;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}