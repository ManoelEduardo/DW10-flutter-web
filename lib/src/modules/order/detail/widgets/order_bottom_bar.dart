// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/ui/styles/text_styles.dart';
import '../../../../dto/order/order_dto.dart';
import '../../../../models/orders/orders_status.dart';
import '../../order_controller.dart';

class OrderBottomBar extends StatelessWidget {
  final OrderController controller;
  final OrderDTO order;
  const OrderBottomBar({
    Key? key,
    required this.controller,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OrderBottomBarButton(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          buttonColor: Colors.blue,
          image: 'asset/images/icons/finish_order_white_ico.png',
          buttonLabel: 'Finalizar',
          onPressed: order.status == OrderStatus.confrimado
              ? () {
                  controller.changeStatus(OrderStatus.finalizado);
                }
              : null,
        ),
        OrderBottomBarButton(
          borderRadius: BorderRadius.zero,
          buttonColor: Colors.green,
          image: 'asset/images/icons/confirm_order_white_icon.png',
          buttonLabel: 'Confirmar',
          onPressed: order.status == OrderStatus.pedente
              ? () {
                  controller.changeStatus(OrderStatus.confrimado);
                }
              : null,
        ),
        OrderBottomBarButton(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          buttonColor: Colors.red,
          image: 'asset/images/icons/cancel_order_white_icon.png',
          buttonLabel: 'Cancelar',
          onPressed: order.status != OrderStatus.cancelado &&
                  order.status != OrderStatus.finalizado
              ? () {
                  controller.changeStatus(OrderStatus.cancelado);
                }
              : null,
        ),
      ],
    );
  }
}

class OrderBottomBarButton extends StatelessWidget {
  final BorderRadius borderRadius;
  final Color buttonColor;
  final String image;
  final String buttonLabel;
  final VoidCallback? onPressed;
  const OrderBottomBarButton({
    Key? key,
    required this.borderRadius,
    required this.buttonColor,
    required this.image,
    required this.buttonLabel,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            side: BorderSide(
              color: onPressed != null ? buttonColor : Colors.transparent,
            ),
            backgroundColor: buttonColor,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(image),
              const SizedBox(
                width: 5,
              ),
              Text(
                buttonLabel,
                style: context.textStyles.textBold.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
