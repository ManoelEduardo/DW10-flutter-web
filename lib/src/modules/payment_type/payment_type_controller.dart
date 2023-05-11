import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../models/payment_type_model.dart';
import '../../repositories/payment_type/payment_type_repository.dart';
part 'payment_type_controller.g.dart';

enum PaymentTypeStateStatus {
  initial,
  loading,
  loaded,
  error,
  addOrUpdatePayment,
}

class PaymentTypeController = PaymentTypeControllerBase
    with _$PaymentTypeController;

abstract class PaymentTypeControllerBase with Store {
  final PaymentTyperepository _paymentTyperepository;

  @readonly
  var _status = PaymentTypeStateStatus.initial;

  @readonly
  var _paymentTypes = <PaymentTypeModel>[];

  @readonly
  String? _errorMessage;

  @readonly
  PaymentTypeModel? _paymentTypeSelected;

  PaymentTypeControllerBase(this._paymentTyperepository);

  void loadPayments() async {
    try {
      _status = PaymentTypeStateStatus.loading;
      _paymentTypes = await _paymentTyperepository.findAll(null);
      _status = PaymentTypeStateStatus.loaded;
    } catch (e, s) {
      log('Erro ao carregar as formas de pagemnto', error: e, stackTrace: s);
      _status = PaymentTypeStateStatus.error;
      _errorMessage = 'Erro ao carregar as formas de pagemnto';
    }
  }

  @action
  void addPayment() async {
    _status = PaymentTypeStateStatus.loading;
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = null;
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }

  @action
  void editPayment(PaymentTypeModel payment) async {
    _status = PaymentTypeStateStatus.loading;
    await Future.delayed(Duration.zero);
    _paymentTypeSelected = payment;
    _status = PaymentTypeStateStatus.addOrUpdatePayment;
  }
}
