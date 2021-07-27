import 'package:automated_inventory/framework/blocevent.dart';
import 'package:automated_inventory/framework/pipe.dart';
import 'package:automated_inventory/framework/viewmodel.dart';

abstract class Bloc<VM extends ViewModel, BE extends BlocEvent> {

  final Pipe<VM> pipeOut = Pipe();

  final Pipe<BE> pipeIn = Pipe();

  Bloc() {
    pipeIn.receive.listen(onReceiveEvent);
  }

  void onReceiveEvent(BE event);

}

