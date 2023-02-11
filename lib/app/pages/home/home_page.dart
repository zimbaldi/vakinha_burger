import 'package:delivery_app/app/core/ui/base_state/base_state.dart';
import 'package:delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:delivery_app/app/pages/home/home_controller.dart';
import 'package:delivery_app/app/pages/home/home_state.dart';
import 'package:delivery_app/app/pages/home/widgets/delivery_product_tile.dart';
import 'package:delivery_app/app/pages/home/widgets/shopping_bag_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() {
    //SharedPreferences.getInstance().then((value) => value.clear());
    controller.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      // ------Abaixo é para testar os helpers------
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     // showLoader();
      //     // await Future.delayed(Duration(seconds: 2));
      //     // hideLoader();
      //     // showError('Teste erro');
      //     // await Future.delayed(const Duration(seconds: 2));
      //     // showInfo('Teste info');
      //     // await Future.delayed(const Duration(seconds: 2));
      //     // showSuccess('Teste sucesso');
      //   },
      // ),
      body: BlocConsumer<HomeController, HomeState>(
        listener: (context, state) {
          state.status.matchAny(
              any: () => hideLoader(),
              loading: () => showLoader(),
              error: () {
                hideLoader();
                showError(state.errorMessage ?? 'Erro desconhecido');
              });
        },
        buildWhen: (previous, current) => current.status.matchAny(
          any: () => false,
          initial: () => true,
          loaded: () => true,
        ),
        builder: (context, state) {
          return Column(
            children: [
              //Text(state.shoppingBag.length.toString()),
              Expanded(
                child: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: ((context, index) {
                    final product = state.products[index];
                    final orders = state.shoppingBag
                        .where((order) => order.product == product);

                    return DeliveryProductTile(
                      product: product,
                      orderProductDto: orders.isNotEmpty ? orders.first : null,
                      // -----Mock-----
                      // ProductModel(
                      //     id: 0,
                      //     name: 'Lanche X',
                      //     description:
                      //         'Lanche acompanha pão, hamburger, muçarela e maionese',
                      //     price: 15.0,
                      //     image:
                      //         'https://assets.unileversolutions.com/recipes-v2/106684.jpg?imwidth=800'),
                    );
                  }),
                ),
              ),
              Visibility(
                visible: state.shoppingBag.isNotEmpty,
                child: ShoppingBagWidget(bag: state.shoppingBag),
              ),
            ],
          );
        },
      ),
    );
  }
}
