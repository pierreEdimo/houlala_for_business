import 'package:flutter/material.dart';
import 'package:houlalaadministrator/service/login_service.dart';
import 'package:provider/provider.dart';

class MainNavigation extends StatefulWidget {
  final List<IconData>? menuItems;
  final List<Widget>? widgetOptions;


  const MainNavigation({
    Key? key,
    this.menuItems,
    this.widgetOptions,
  }) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  late bool _isSelected = false;
  late int _currentIndex = 0;
  final ScrollController? scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 60.0,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 1,
                  color: Colors.grey.shade200,
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.menuItems!.length,
                    itemBuilder: (BuildContext context, int index) {
                      IconData menuIcon = widget.menuItems![index];
                      _isSelected = _currentIndex == index;

                      return InkWell(
                        onTap: () {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(
                            child: Icon(
                              menuIcon,
                              color: _isSelected
                                  ? const Color(0xffdf972f)
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Provider.of<LoginService>(context, listen: false)
                        .logout(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                    child: Center(
                      child: Icon(
                        Icons.logout_outlined,
                        color: Colors.red,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Scaffold(
              backgroundColor: const Color(0xf2f2f2f2),
              body: SingleChildScrollView(
                controller: scrollController,
                  child: widget.widgetOptions!.elementAt(_currentIndex)),
            ),
          ),
        ],
      ),
    );
  }
}
