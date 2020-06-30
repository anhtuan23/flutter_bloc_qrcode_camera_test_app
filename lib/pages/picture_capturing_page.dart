import 'dart:io';

import 'package:bloc_barcode_camera_demo_app/bloc/appbloc.dart';
import 'package:bloc_barcode_camera_demo_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PictureCapturingPage extends StatefulWidget {
  @override
  _PictureCapturingPageState createState() => _PictureCapturingPageState();
}

class _PictureCapturingPageState extends State<PictureCapturingPage> {
  // Add two variables to the state class to store the CameraController and
  // the Future.
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    
    // Obtain a list of the available cameras on the device.
    availableCameras().then((cameras) {
      // Get a specific camera from the list of available cameras.
      var camera = cameras.first;
      // To display the current output from the camera,
      // create a CameraController.
      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
      );

      // Next, initialize the controller. This returns a Future.
      _initializeControllerFuture = _controller.initialize();
      
      // Must call setState to update this future to the widget future builder
      setState(() {});
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBloc bloc = BlocProvider.of<AppBloc>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Take a picture"),
        ),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // If the Future is complete, display the preview.
              return CameraPreview(_controller);
            } else {
              // Otherwise, display a loading indicator.
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera_alt),
          // Provide an onPressed callback.
          onPressed: () async {
            // Take the Picture in a try / catch block. If anything goes wrong,
            // catch the error.
            try {
              // Ensure that the camera is initialized.
              await _initializeControllerFuture;

              // Construct the path where the image should be saved using the
              // pattern package.
              final path = join(
                // Store the picture in the temp directory.
                // Find the temp directory using the `path_provider` plugin.
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );

              // Attempt to take a picture and log where it's been saved.
              await _controller.takePicture(path);

              bloc.state.imagePaths.insert(0, path);

              // If the picture was taken, send path back to user info page
              BlocProvider.of<AppBloc>(context).add(PictureCaptured(
                barcodeResult: bloc.state.barcodeResult,
                username: bloc.state.username,
                password: bloc.state.password,
                imagePaths: bloc.state.imagePaths,
              ));
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
        ),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
