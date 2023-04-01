import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thriftly/data/providers/item_listing_provider.dart';
import 'package:thriftly/data/repositories/item_listing_repository.dart';
import 'package:thriftly/helpers/firebase_functions.dart';
import 'package:thriftly/logic/item_listing/item_listing_bloc.dart';
import 'package:thriftly/logic/item_listing/item_listing_event.dart';
import 'package:thriftly/logic/item_listing/item_listing_state.dart';

class CreatePageRedirect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final itemListingRepository =
        new ItemListingRepository(new ItemListingProvider());

    return Container(
      alignment: Alignment.center,
      child: BlocProvider<ItemListingBloc>(
        create: (context) => ItemListingBloc(itemListingRepository),
        child: CreateItemListingPage(),
      ),
    );
  }
}

class CreateDecisionPage extends StatelessWidget {
  const CreateDecisionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xff0BA400),
            child: Padding(
              padding: const EdgeInsets.only(top: 90.0, left: 30),
              child: Text(
                "Create",
                style: GoogleFonts.poppins(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "select your post type",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          MaterialButton(
            onPressed: () {
              BlocProvider.of<ItemListingBloc>(context)
                  .add(NavigateToCreateItemListingForm());
            },
            child: Column(
              children: [
                Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/thriftly-bc3f0.appspot.com/o/Banknote-amico.png?alt=media&token=5e6fe1be-7300-4432-b0d7-ab447acdb73e",
                  height: 200,
                  width: 200,
                ),
                Text(
                  "list an item for sale",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 5,
            width: 100,
            color: Colors.black,
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () {
              BlocProvider.of<ItemListingBloc>(context)
                  .add(NavigateToPostOutfitInspo());
            },
            child: Column(
              children: [
                Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/thriftly-bc3f0.appspot.com/o/Choosing%20clothes-amico.png?alt=media&token=14ac33a6-5868-4c86-8e07-b8fa4088da7d",
                  height: 200,
                  width: 200,
                ),
                Text(
                  "post outfit inspo",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CreateItemListingPage extends StatelessWidget {
  const CreateItemListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ItemListingBloc, ItemListingState>(
      listener: (context, state) {
        if (state is ItemListingCreated) {
          print(state);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Created Item Listing"),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(right: 20, left: 20),
          ));
        }
      },
      builder: (context, state) {
        if (state is ItemListingInitial) {
          return CreateDecisionPage();
        }

        if (state is RedirectToCreateItemListing) {
          return CreateItemListingForm();
        }

        if (state is RedirectToPostOutfitInspo) {
          return CreateOutfitInspo();
        }

        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class CreateItemListingForm extends StatefulWidget {
  const CreateItemListingForm({Key? key}) : super(key: key);

  @override
  State<CreateItemListingForm> createState() => _CreateFormState();
}

class _CreateFormState extends State<CreateItemListingForm> {
  var imageFile;
  int _activeStepIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  // define some controllers
  TextEditingController title = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController size = new TextEditingController();
  TextEditingController location = new TextEditingController();
  TextEditingController price = new TextEditingController();

  List<Step> createSteps() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Basic Info'),
          content: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: title,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Listing Title',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: description,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Listing Description',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  keyboardType: TextInputType.multiline,
                  controller: size,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Size',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: price,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text('Location'),
            content: Container(
              child: Column(
                children: [
                  TextField(
                    controller: location,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Location',
                    ),
                  ),
                ],
              ),
            )),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Add an Image'),
            content: Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      XFile? pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 1800,
                        maxHeight: 1800,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          imageFile = File(pickedFile.path);
                        });
                      } else {
                        return;
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          "Choose Image From Gallery",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      XFile? pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        maxWidth: 1800,
                        maxHeight: 1800,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          imageFile = File(pickedFile.path);
                        });
                      } else {
                        return;
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          "Take an Photo",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.file(imageFile),
                        )
                      : Center(
                          child: Text("No Image Selected"),
                        ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 3,
            title: const Text('Confirm'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Title: ${title.text}'),
                Text('Body: ${description.text}'),
                Text('Weight: ${size.text}'),
                Text('Location : ${location.text}'),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text("Image: "),
                ),
                imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.file(imageFile),
                      )
                    : Text("No Image Selected"),
              ],
            )))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Create",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  color: const Color(0xffFFFFFF)),
            ),
          ),
          backgroundColor: const Color(0xff0BA400),
        ),
        body: Container(
          child: Container(
            child: Center(
              child: Theme(
                data: ThemeData(
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: const Color(0xff0BA400),
                  ),
                ),
                child: Stepper(
                  type: StepperType.vertical,
                  currentStep: _activeStepIndex,
                  steps: createSteps(),
                  onStepContinue: () {
                    if (_activeStepIndex < (createSteps().length - 1)) {
                      setState(() {
                        _activeStepIndex += 1;
                      });
                    } else {
                      print("here");
                      BlocProvider.of<ItemListingBloc>(context)
                          .add(CreateItemListing(
                        title: title.text,
                        description: description.text,
                        price: price.text,
                        size: size.text,
                        imageFile: imageFile,
                        location: location.text,
                      ));
                    }
                  },
                  onStepCancel: () {
                    if (_activeStepIndex == 0) {
                      return;
                    }
                    setState(() {
                      _activeStepIndex -= 1;
                    });
                  },
                  onStepTapped: (int index) {
                    setState(() {
                      _activeStepIndex = index;
                    });
                  },
                  controlsBuilder: (context, controlDetails) {
                    final isLastStep =
                        _activeStepIndex == createSteps().length - 1;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: controlDetails.onStepContinue,
                                child: (isLastStep)
                                    ? const Text('Submit')
                                    : const Text('Next'),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (_activeStepIndex > 0)
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: controlDetails.onStepCancel,
                                  child: const Text('Back'),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}

class CreateOutfitInspo extends StatefulWidget {
  const CreateOutfitInspo({Key? key}) : super(key: key);

  @override
  State<CreateOutfitInspo> createState() => _CreateOutfitInspoState();
}

class _CreateOutfitInspoState extends State<CreateOutfitInspo> {
  var imageFile;
  int _activeStepIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  // define some controllers
  TextEditingController caption = new TextEditingController();

  List<Step> createSteps() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text('Basic Info'),
          content: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: caption,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Caption',
                  ),
                ),
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text('Add an Image'),
            content: Container(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      XFile? pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        maxWidth: 1800,
                        maxHeight: 1800,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          imageFile = File(pickedFile.path);
                        });
                      } else {
                        return;
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          "Choose Image From Gallery",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      XFile? pickedFile = await ImagePicker().pickImage(
                        source: ImageSource.camera,
                        maxWidth: 1800,
                        maxHeight: 1800,
                      );
                      if (pickedFile != null) {
                        setState(() {
                          imageFile = File(pickedFile.path);
                        });
                      } else {
                        return;
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      padding: EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          "Take an Photo",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  imageFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          child: Image.file(imageFile),
                        )
                      : Center(
                          child: Text("No Image Selected"),
                        ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 3,
            title: const Text('Confirm'),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Caption: ${caption.text}'),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text("Image: "),
                ),
                imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.file(imageFile),
                      )
                    : Text("No Image Selected"),
              ],
            )))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          title: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Create",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  color: const Color(0xffFFFFFF)),
            ),
          ),
          backgroundColor: const Color(0xff0BA400),
        ),
        body: Container(
          child: Container(
            child: Center(
              child: Theme(
                data: ThemeData(
                  colorScheme: ColorScheme.fromSwatch().copyWith(
                    primary: const Color(0xff0BA400),
                  ),
                ),
                child: Stepper(
                  type: StepperType.vertical,
                  currentStep: _activeStepIndex,
                  steps: createSteps(),
                  onStepContinue: () {
                    if (_activeStepIndex < (createSteps().length - 1)) {
                      setState(() {
                        _activeStepIndex += 1;
                      });
                    } else {
                      print("here");
                      BlocProvider.of<ItemListingBloc>(context)
                          .add(CreateOutfitInspoEvent(
                        caption: caption.text,
                        imageFile: imageFile,
                      ));
                    }
                  },
                  onStepCancel: () {
                    if (_activeStepIndex == 0) {
                      return;
                    }
                    setState(() {
                      _activeStepIndex -= 1;
                    });
                  },
                  onStepTapped: (int index) {
                    setState(() {
                      _activeStepIndex = index;
                    });
                  },
                  controlsBuilder: (context, controlDetails) {
                    final isLastStep =
                        _activeStepIndex == createSteps().length - 1;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: controlDetails.onStepContinue,
                                child: (isLastStep)
                                    ? const Text('Submit')
                                    : const Text('Next'),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            if (_activeStepIndex > 0)
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: controlDetails.onStepCancel,
                                  child: const Text('Back'),
                                ),
                              )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ));
  }
}
