import 'package:flutter/material.dart';
import 'package:flutternodeapp/constants/global_variables.dart';
import 'package:flutternodeapp/features/search/screens/search_screen.dart';
import 'package:intl/intl.dart';
import '../../../models/order.dart';

class OrderDetailScreen extends StatefulWidget {
  static const routeName = '/order-details';
  final Order order;
  const OrderDetailScreen({super.key, required this.order});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int currentstep =0;
  void navigateToSearchScreen(String queery) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: queery);
  }
 @override
  void initState() {
    super.initState();
    currentstep= widget.order.status;
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 0,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7))),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'View Order details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Data:        ${DateFormat().format(
                        DateTime.fromMillisecondsSinceEpoch(
                            widget.order.orderedAt),
                      )}",
                    ),
                    Text('Order Id:         ${widget.order.id}'),
                    Text('Order Total:      ${widget.order.totalPrice}')
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Purchase details',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.products.length; i++)
                      Row(
                        children: [
                          Image.network(
                            widget.order.products[i].images[0],
                            height: 120,
                            width: 120,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.order.products[i].name,
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text('${widget.order.quantity[i]}')
                            ],
                          )),
                        ],
                      )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Tracking',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
                child: Stepper(
                  currentStep: currentstep,
                  steps: [
                    Step(
                      title: const Text("Pending"),
                      content: const Text(
                        "Your order is yet to be delivered",
                      ),
                      isActive: currentstep>0,
                      state: currentstep >0? StepState.complete:StepState.indexed
                    ),
                     Step(
                      title: const Text("Completed"),
                      content: const Text(
                        "Your order has been delivered,you are yet to sing",
                      ),
                      isActive: currentstep>1,
                      state: currentstep >1 ?StepState.complete:StepState.indexed
                    ),
                    Step(
                      title:const  Text("Received"),
                      content: const Text(
                        "Your order has been delivered and signed by you",
                      ),
                      isActive: currentstep>2,
                      state: currentstep >2?StepState.complete:StepState.indexed
                    ),
                    Step(
                      title: const Text("Delivered"),
                      content:const  Text(
                        "Your order has been delivered and signed by you",
                      ),
                      isActive: currentstep>=3,
                      state: currentstep >=3?StepState.complete:StepState.indexed
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
