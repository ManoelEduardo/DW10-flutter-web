// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../models/orders/orders_status.dart';
import '../../models/payment_type_model.dart';
import '../../models/user_model.dart';
import 'order_product_dto.dart';

class OrderDTO {
  final int id;
  final DateTime date;
  final OrderStatus status;
  final List<OrderProductDTO> orderProducts;
  final UserModel user;
  final String address;
  final String cpf;
  final PaymentTypeModel paymentTypeModel;
  OrderDTO({
    required this.id,
    required this.date,
    required this.status,
    required this.orderProducts,
    required this.user,
    required this.address,
    required this.cpf,
    required this.paymentTypeModel,
  });
}
