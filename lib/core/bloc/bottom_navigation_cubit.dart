import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  void changeSelectedIndexJobseeker(int index) {
    emit(index);
  }

  void reset() {
    emit(0);
  }
}
