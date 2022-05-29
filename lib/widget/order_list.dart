import 'package:flutter/material.dart';
import 'package:houlalaadministrator/service/order_service.dart';
import 'package:provider/provider.dart';

import '../model/order_model.dart';
import 'created_at_container.dart';

class OrderList extends StatelessWidget {
  final String? url;
  final String? msg;

  const OrderList({
    Key? key,
    this.url,
    this.msg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<OrderService>(context).fetchOrders(url!),
      builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
        if (snapshot.hasData) {
          List<Order>? orders = snapshot.data;

          return orders!.isEmpty
              ? Text("Vous avez ${orders.length}  $msg")
              : DataTable(
                  columns: const [
                      DataColumn(
                        label: Text("id"),
                      ),
                      DataColumn(
                        label: Text("Date"),
                      ),
                      DataColumn(
                        label: Text("client"),
                      ),
                      DataColumn(
                        label: Text("status "),
                      ),
                      DataColumn(
                        label: Text("prix"),
                      )
                    ],
                  rows: orders
                      .map(
                        (Order order) => DataRow(
                          cells: [
                            const DataCell(
                              Text(
                                "101",
                              ),
                            ),
                            DataCell(
                                CreatedAtContainer(dateTime: order.createdAt)),
                            DataCell(
                              InkWell(
                                onTap: () => Navigator.of(context).pushNamed(
                                  '/order-detail',
                                  arguments: order
                                ),
                                child: Text(
                                  order.userInformation!.lastName!,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(order.status!),
                            ),
                            DataCell(
                              Text(
                                order.totalPrice.toString(),
                              ),
                            )
                          ],
                        ),
                      )
                      .toList());
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
