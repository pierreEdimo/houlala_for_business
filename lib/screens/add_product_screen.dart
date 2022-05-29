import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:houlalaadministrator/constant/constants.dart';
import 'package:houlalaadministrator/model/custom_button.dart';
import 'package:houlalaadministrator/service/category_service.dart';
import 'package:houlalaadministrator/service/product_service.dart';
import 'package:houlalaadministrator/service/product_type_service.dart';
import 'package:houlalaadministrator/widget/custom_card.dart';
import 'package:houlalaadministrator/widget/dropdown_category.dart';
import 'package:houlalaadministrator/widget/dropdown_product_type.dart';
import 'package:houlalaadministrator/widget/input_number.dart';
import 'package:houlalaadministrator/widget/input_name.dart';
import 'package:houlalaadministrator/widget/title.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:zefyrka/zefyrka.dart';
import '../model/add_product.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String pageId = ModalRoute.of(context)!.settings.arguments as String;
    return AddProductScreenForm(
      pageId: pageId,
    );
  }
}

class AddProductScreenForm extends StatefulWidget {
  final String? pageId;

  const AddProductScreenForm({
    Key? key,
    this.pageId,
  }) : super(key: key);

  @override
  State<AddProductScreenForm> createState() => _AddProductScreenFormState();
}

class _AddProductScreenFormState extends State<AddProductScreenForm> {
  final TextEditingController _nameController = TextEditingController();
  final ZefyrController _controller = ZefyrController();
  final TextEditingController _sellingPriceController = TextEditingController();
  final TextEditingController _buyingPriceController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    late XFile? imageFile = Provider.of<ProductService>(context).getImageFile();
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.keyboard_arrow_left_outlined,
            color: Colors.black,
          ),
        ),
        automaticallyImplyLeading: false,
        title: const CustomTitle(
          title: "Ajouter un Produit",
          size: 22.0,
        ),
        backgroundColor: Colors.grey.shade200,
      ),
      body: ResponsiveBuilder(
        breakpoints: const ScreenBreakpoints(
          desktop: 1280,
          tablet: 1024,
          watch: 300,
        ),
        builder: (BuildContext context, SizingInformation sizingInformation) {
          switch (sizingInformation.deviceScreenType) {
            case DeviceScreenType.mobile:
              return Form(
                key: _formKey,
                child: MobileFormScreen(
                  nameController: _nameController,
                  buyingPriceController: _buyingPriceController,
                  weightController: _weightController,
                  controller: _controller,
                  quantityController: _quantityController,
                  sellingPriceController: _sellingPriceController,
                  imageFile: imageFile,
                ),
              );
            case DeviceScreenType.tablet:
              return Form(
                key: _formKey,
                child: FormScreen(
                  nameController: _nameController,
                  buyingPriceController: _buyingPriceController,
                  weightController: _weightController,
                  controller: _controller,
                  quantityController: _quantityController,
                  sellingPriceController: _sellingPriceController,
                  width: MediaQuery.of(context).size.width * 0.65,
                  imageFile: imageFile,
                ),
              );
            case DeviceScreenType.desktop:
            default:
              return Form(
                key: _formKey,
                child: FormScreen(
                  nameController: _nameController,
                  buyingPriceController: _buyingPriceController,
                  weightController: _weightController,
                  controller: _controller,
                  quantityController: _quantityController,
                  sellingPriceController: _sellingPriceController,
                  width: MediaQuery.of(context).size.width * 0.50,
                  imageFile: imageFile,
                ),
              );
          }
        },
      ),
      floatingActionButton: InkWell(
        onTap: () async {
          String categoryId =
              Provider.of<CategoryService>(context, listen: false)
                  .getCategoryId();
          String subCategoryId =
              Provider.of<ProductTypeService>(context, listen: false)
                  .getSubCategoryId();
          if (_formKey.currentState!.validate()) {
            AddProduct newProduct = AddProduct(
                name: _nameController.text,
                weight: int.parse(_weightController.text),
                quantity: int.parse(_quantityController.text),
                sellingPrice: int.parse(_sellingPriceController.text),
                buyingPrice: int.parse(_buyingPriceController.text),
                productType: subCategoryId,
                categoryId: categoryId,
                description: _controller.plainTextEditingValue.text,
                pageId: widget.pageId);

            await Provider.of<ProductService>(context, listen: false)
                .addProduct(
              imageFile!,
              newProduct,
            );

            if (!mounted) {
              return;
            }

            Navigator.of(context).pop();
          }
        },
        child: const CustomButton(
          title: "Enregistrer",
        ),
      ),
    );
  }
}

class MobileFormScreen extends StatefulWidget {
  final TextEditingController? nameController;
  final ZefyrController? controller;
  final TextEditingController? sellingPriceController;
  final TextEditingController? buyingPriceController;
  final TextEditingController? weightController;
  final TextEditingController? quantityController;
  final XFile? imageFile;

  const MobileFormScreen({
    Key? key,
    this.nameController,
    this.controller,
    this.sellingPriceController,
    this.buyingPriceController,
    this.weightController,
    this.quantityController,
    this.imageFile,
  }) : super(key: key);

  @override
  State<MobileFormScreen> createState() => _MobileFormScreenState();
}

class _MobileFormScreenState extends State<MobileFormScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 30.0,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTitle(
                          title: "Nom",
                          size: 18.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        NameInput(
                          controller: widget.nameController,
                          minLines: 1,
                          maxLines: 1,
                          label: "Ajouter le nom",
                        ),
                        standardVerticalSpace,
                        const CustomTitle(
                          title: "Description",
                          size: 18.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ZefyrToolbar.basic(
                                  controller: widget.controller!),
                              Expanded(
                                child: ZefyrEditor(
                                  controller: widget.controller!,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  standardVerticalSpace,
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTitle(
                          title: "Image",
                          size: 18.0,
                        ),
                        standardVerticalSpace,
                        SizedBox(
                          height: 400,
                          child: widget.imageFile == null
                              ? Container()
                              : kIsWeb
                                  ? Image.network(
                                      widget.imageFile!.path,
                                      fit: BoxFit.fitHeight,
                                    )
                                  : Image.file(
                                      File(widget.imageFile!.path),
                                    ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1,
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Provider.of<ProductService>(context,
                                      listen: false)
                                  .pickImage();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: const Text("ajouter une Image"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  standardVerticalSpace,
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTitle(
                          title: "Prix",
                          size: 18.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          children: [
                            NumberInput(
                              controller: widget.sellingPriceController,
                              label: "prix de vente",
                              hintText: "prix de vente",
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            NumberInput(
                              controller: widget.buyingPriceController,
                              label: "prix d'achat",
                              hintText: "prix d'achat",
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  standardVerticalSpace,
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTitle(
                          title: "Infos additionelles",
                          size: 18.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        NumberInput(
                          controller: widget.weightController,
                          hintText: "Poids",
                          label: "Poids",
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        NumberInput(
                          controller: widget.quantityController,
                          hintText: "Quantite",
                          label: "Quantite",
                        )
                      ],
                    ),
                  ),
                  standardVerticalSpace,
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTitle(
                          title: "Categorie",
                          size: 18.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Column(
                          children: const [
                            DropdownCategory(),
                            SizedBox(
                              height: 10.0,
                            ),
                            DropdownProductType()
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FormScreen extends StatefulWidget {
  final TextEditingController? nameController;
  final ZefyrController? controller;
  final TextEditingController? sellingPriceController;
  final TextEditingController? buyingPriceController;
  final TextEditingController? weightController;
  final TextEditingController? quantityController;
  final double? width;
  final XFile? imageFile;

  const FormScreen({
    Key? key,
    this.nameController,
    this.controller,
    this.sellingPriceController,
    this.buyingPriceController,
    this.weightController,
    this.quantityController,
    this.width,
    this.imageFile,
  }) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 30.0,
        ),
        child: Row(
          children: [
            const Spacer(),
            SizedBox(
              width: widget.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTitle(
                          title: "Nom",
                          size: 18.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        NameInput(
                          controller: widget.nameController,
                          minLines: 1,
                          maxLines: 1,
                          label: "Ajouter le nom",
                        ),
                        standardVerticalSpace,
                        const CustomTitle(
                          title: "Description",
                          size: 18.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: Colors.grey.shade200),
                              borderRadius: BorderRadius.circular(5.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              ZefyrToolbar.basic(
                                  controller: widget.controller!),
                              Expanded(
                                child: ZefyrEditor(
                                  controller: widget.controller!,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  standardVerticalSpace,
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTitle(
                          title: "Image",
                          size: 18.0,
                        ),
                        standardVerticalSpace,
                        SizedBox(
                          height: 400,
                          child: widget.imageFile == null
                              ? Container()
                              : Image.network(
                                  widget.imageFile!.path,
                                  fit: BoxFit.fitHeight,
                                ),
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1,
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Provider.of<ProductService>(context,
                                      listen: false)
                                  .pickImage();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: const Text("ajouter une Image"),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  standardVerticalSpace,
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTitle(
                          title: "Prix",
                          size: 18.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: NumberInput(
                                controller: widget.sellingPriceController,
                                label: "prix de vente",
                                hintText: "prix de vente",
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: NumberInput(
                                controller: widget.buyingPriceController,
                                label: "prix d'achat",
                                hintText: "prix d'achat",
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  standardVerticalSpace,
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTitle(
                          title: "Infos additionelles",
                          size: 18.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        NumberInput(
                          controller: widget.weightController,
                          hintText: "Poids",
                          label: "Poids",
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        NumberInput(
                          controller: widget.quantityController,
                          hintText: "Quantite",
                          label: "Quantite",
                        )
                      ],
                    ),
                  ),
                  standardVerticalSpace,
                  CustomCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTitle(
                          title: "Categorie",
                          size: 18.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          children: const [
                            Expanded(
                              child: DropdownCategory(),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              child: DropdownProductType(),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
