import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/ui/helpers/loader.dart';
import '../../core/ui/helpers/messages.dart';
import 'detail/order_detail_modal.dart';
import 'order_controller.dart';
import 'widgets/order_header.dart';
import 'widgets/order_item.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with Loader, Messages {
  final orderController = Modular.get<OrderController>();
  late final ReactionDisposer statusDisposer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      statusDisposer = reaction((_) => orderController.status, (status) {
        switch (status) {
          case OrderStateStatus.initial:
            break;
          case OrderStateStatus.loading:
            showLoader();
            break;
          case OrderStateStatus.loaded:
            hideLoader();
            break;
          case OrderStateStatus.error:
            hideLoader();
            showError(
              orderController.errorMessage ?? 'Erro interno',
            );
            break;
          case OrderStateStatus.showDetailModal:
            hideLoader();
            showDetailModal();
            break;
          case OrderStateStatus.statusChanged:
            hideLoader();
            Navigator.of(context, rootNavigator: true).pop();
            orderController.findOrders();
            break;
        }
      });
      orderController.findOrders();
    });
  }

  void showDetailModal() {
    showDialog(
      context: context,
      builder: (context) {
        return OrderDetailModal(
          controller: orderController,
          order: orderController.orderSelected!,
        );
      },
    );
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constrains) {
        return Container(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              OrderHeader(controller: orderController),
              const SizedBox(
                height: 50,
              ),
              Expanded(
                child: Observer(
                  builder: (_) {
                    return GridView.builder(
                      itemCount: orderController.orders.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        mainAxisExtent: 91,
                        maxCrossAxisExtent: 600,
                      ),
                      itemBuilder: (context, index) {
                        return OrderItem(order: orderController.orders[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
