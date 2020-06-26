import 'package:bloc_barcode_camera_demo_app/bloc/appbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_scan/barcode_scan.dart';


class BarcodeScanningPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Barcode Scanning"),
        ),
        body: BlocBuilder<AppBloc, AppBlocState>(
          builder: (context, state) {
            return Center(
              child: Text(state.message),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera),
          onPressed: () async {
            var result = await BarcodeScanner.scan();
            switch (result.type) {
              case ResultType.Barcode:
                BlocProvider.of<AppBloc>(context)
                    .add(AppBarcodeResultReceived(result.rawContent));
                break;
              case ResultType.Cancelled:
              case ResultType.Error:
              default:
                BlocProvider.of<AppBloc>(context)
                    .add(AppBarcodeResultErrorReceived());
            }
          },
        ),
      ),
    );
  }
}

