import 'package:flutter/material.dart';

import '../main.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductItem productItem;

  ProductDetailsScreen({Key? key, required this.productItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool isLargeScreen = constraints.maxWidth >= 650;

print( '123');
          print( productItem);

          if (isLargeScreen) {
            return AppStateWidget(
                child: horizontalDetail(context), productItem: productItem);
          } else {
            return AppStateWidget(
                child: verticalDetail(context), productItem: productItem);
          }
        },
      ),
    );
  }

  verticalDetail(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 400,
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.network(
                productItem.urlImg,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProductInfo(context),
              ],
            ),
          ),
          _buildMoreImages(context),
        ],
      ),
    );
  }

  horizontalDetail(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Image.network(
                    productItem.urlImg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductInfo(context),
                  ],
                ),
              ),
            ],
          ),
          _buildMoreImages(context),
        ],
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context) {
    return Container(
      width: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productItem.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Text(
            productItem.productNumber,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Text(
            productItem.subtitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(height: 8),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          SizedBox(height: 16),
          Container(
            height: 50,
            child: Row(
              children: [
                Text(
                  '顏色',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                Wrap(
                  spacing: 8,
                  children: List<Widget>.generate(
                    productItem.colorOption.length,
                    (index) {
                      Color color = productItem.colorOption[index].color;
                      return GestureDetector(
                        onTap: () {
                          AppStateWidget.of(context)
                              .setSelectedColorIndex(index);
                          AppStateWidget.of(context).setSelectedSizeIndex(0);
                          AppStateWidget.of(context).setQuantity(1);
                          // setState(() {
                          //   selectedColorIndex = index;
                          //   selectedSizeIndex = 0;
                          //   quantity = 1;
                          // });
                        },
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: color,
                            border: Border.all(
                              color: AppStateScope.of(context)
                                          .selectedColorIndex ==
                                      index
                                  ? Colors.red
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 50,
            child: Row(
              children: [
                Text(
                  '尺寸',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                SizedBox(width: 8),
                Wrap(
                  spacing: 8,
                  children: AppStateScope.of(context)
                      .availableSizes
                      .map(
                        (sizeOption) => ChoiceChip(
                          label: Text(sizeOption.size),
                          selected:
                              AppStateScope.of(context).selectedSizeIndex ==
                                  AppStateScope.of(context)
                                      .availableSizes
                                      .indexOf(sizeOption),
                          onSelected: (isSelected) {
                            AppStateWidget.of(context).setSelectedSizeIndex(
                                AppStateScope.of(context)
                                    .availableSizes
                                    .indexOf(sizeOption));
                            AppStateWidget.of(context).setQuantity(1);

                            // setState(() {
                            //   selectedSizeIndex =
                            //       availableSizes.indexOf(sizeOption);
                            //   quantity = 1;
                            // });
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 50,
            child: Row(
              children: [
                Text(
                  '數量',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                VerticalDivider(
                  color: Colors.grey,
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    if (AppStateScope.of(context).quantity > 1) {
                      AppStateWidget.of(context)
                          .setQuantity(AppStateScope.of(context).quantity--);

                      // setState(() {
                      //   quantity--;
                      // });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  '${AppStateScope.of(context).quantity}',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  width: 16,
                ),
                InkWell(
                  onTap: () {
                    ColorOption colorOption = productItem.colorOption[
                        AppStateScope.of(context).selectedColorIndex];
                    SizeOption sizeOption = colorOption.sizeOptions[
                        AppStateScope.of(context).selectedSizeIndex];
                    if (AppStateScope.of(context).quantity < sizeOption.stock) {
                      AppStateWidget.of(context)
                          .setQuantity(AppStateScope.of(context).quantity++);

                      // setState(() {
                      //   quantity++;
                      // });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          MaterialButton(
            minWidth: 300.0,
            height: 50.0,
            color: Colors.grey[800],
            onPressed: () {},
            child: Text(
              '請選擇購物車',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            productItem.descriptions,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildMoreImages(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'More Images',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          SizedBox(
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 16),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: productItem.moreImgs.length,
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Image.network(
                      productItem.moreImgs[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AppState {
  AppState({
    this.quantity = 1,
    this.selectedColorIndex = 1,
    this.selectedSizeIndex = 1,
    this.availableSizes = const <SizeOption>[],
    this.maxQuantity = 0,
  });

  int quantity = 1;
  int selectedColorIndex = 1;
  int selectedSizeIndex = 1;
  List<SizeOption> availableSizes;
  int maxQuantity;

  AppState copyWith({
    int? quantity,
    int? selectedColorIndex,
    int? selectedSizeIndex,
    List<SizeOption>? availableSizes,
    int? maxQuantity,
  }) {
    return AppState(
      quantity: quantity ?? this.quantity,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
      selectedSizeIndex: selectedSizeIndex ?? this.selectedSizeIndex,
      availableSizes: availableSizes ?? this.availableSizes,
      maxQuantity: maxQuantity ?? this.maxQuantity,
    );
  }
}

class AppStateScope extends InheritedWidget {
  const AppStateScope(this.data, {Key? key, required Widget child})
      : super(key: key, child: child);

  final AppState data;

  static AppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AppStateScope>()!.data;
  }

  @override
  bool updateShouldNotify(AppStateScope oldWidget) {
    return data != oldWidget.data;
  }
}

class AppStateWidget extends StatefulWidget {
  const AppStateWidget(
      {required this.child, required this.productItem, Key? key})
      : super(key: key);

  final ProductItem productItem;
  final Widget child;

  static AppStateWidgetState of(BuildContext context) {
    return context.findAncestorStateOfType<AppStateWidgetState>()!;
  }

  @override
  AppStateWidgetState createState() => AppStateWidgetState();
}

class AppStateWidgetState extends State<AppStateWidget> {
  int quantity = 1;
  int selectedColorIndex = 1;
  int selectedSizeIndex = 1;

  List<SizeOption> get availableSizes {
    return widget.productItem.colorOption[selectedColorIndex].sizeOptions
        .where((sizeOption) => sizeOption.stock > 0)
        .toList();
  }

  int get maxQuantity {
    return availableSizes.isNotEmpty
        ? availableSizes[selectedSizeIndex].stock
        : 0;
  }

  AppState _data = AppState(
    quantity: 0,
    selectedColorIndex: 0,
    selectedSizeIndex: 0,
  );

  void setSelectedColorIndex(int newColorIndex) {
    if (newColorIndex != _data.selectedColorIndex) {
      setState(() {
        _data = _data.copyWith(
          selectedColorIndex: newColorIndex,
        );
      });
    }
  }

  void setSelectedSizeIndex(int newSizeIndex) {
    if (newSizeIndex != _data.selectedSizeIndex) {
      setState(() {
        _data = _data.copyWith(
          selectedSizeIndex: newSizeIndex,
        );
      });
    }
  }

  void setQuantity(int newQuantity) {
    if (newQuantity != _data.quantity) {
      setState(() {
        _data = _data.copyWith(quantity: newQuantity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.productItem);
    AppState _data = AppState(
        quantity: 0,
        selectedColorIndex: 0,
        selectedSizeIndex: 0,
        availableSizes: availableSizes,
        maxQuantity: maxQuantity);

    return AppStateScope(
      _data,
      child: widget.child,
    );
  }
}
