import '../../dto/order/order_product_dto.dart';
import '../../models/orders/order_model.dart';
import '../../dto/order/order_dto.dart';
import '../../models/payment_type_model.dart';
import '../../models/user_model.dart';
import '../../repositories/payment_type/payment_type_repository.dart';
import '../../repositories/products/product_repository.dart';
import '../../repositories/user/user_repository.dart';
import 'get_order_by_id.dart';

class GetOrderByIdImpl implements GetOrderById {
  final PaymentTyperepository _paymentTypeRepository;
  final UserRepository _userRepository;
  final ProductRepository _productRepository;

  GetOrderByIdImpl(
    this._paymentTypeRepository,
    this._userRepository,
    this._productRepository,
  );

  @override
  Future<OrderDTO> call(OrderModel order) => _orderDTOParse(order);

  Future<OrderDTO> _orderDTOParse(OrderModel order) async {
    final paymentTypeFuture =
        _paymentTypeRepository.getById(order.paymentTypeId);
    final userFuture = _userRepository.getById(order.userId);
    final orderProductsFuture = _orderProductParse(order);

    final responses =
        await Future.wait([paymentTypeFuture, userFuture, orderProductsFuture]);

    return OrderDTO(
      id: order.id,
      date: order.date,
      status: order.status,
      orderProducts: responses[2] as List<OrderProductDTO>,
      user: responses[1] as UserModel,
      address: order.address,
      cpf: order.cpf,
      paymentTypeModel: responses[0] as PaymentTypeModel,
    );
  }

  Future<List<OrderProductDTO>> _orderProductParse(OrderModel order) async {
    final orderProducts = <OrderProductDTO>[];
    final productsFuture = order.orderProducts
        .map((e) => _productRepository.getProduct(e.productId))
        .toList();

    final products = await Future.wait(productsFuture);

    for (var i = 0; i < order.orderProducts.length; i++) {
      final orderProduct = order.orderProducts[i];
      final productDto = OrderProductDTO(
        product: products[i],
        amount: orderProduct.amount,
        totalPrice: orderProduct.totalPrice,
      );
      orderProducts.add(productDto);
    }
    return orderProducts;
  }
}
