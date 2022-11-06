import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final  counterProvider = ChangeNotifierProvider((ref) => CounterProvider());

final countStateProvider = StateProvider<int>((ref) => 0);

class  CounterProvider extends ChangeNotifier{

  int number = 0;

  void increment(){
    number++;
    notifyListeners();
  }

  void decrement(){
    number--;
    notifyListeners();
  }


}

// class A{
//   final int a;
//   A(this.a);
//
// }
//
//
// class B extends A{
//   B(super.a);
//
// }



final countNotify = StateNotifierProvider<CounterStateNotifierProvider, int>((ref) => CounterStateNotifierProvider(0));

class CounterStateNotifierProvider extends StateNotifier<int>{
  CounterStateNotifierProvider(super.state);


  void increment(){
    state++;
  }

  void decrement(){
    state--;
  }


}




class TodoState{
  List<Todo> todos;
  bool isLoad;

  TodoState({required this.isLoad, required this.todos});

  TodoState.initState() : todos=[], isLoad=false;
  TodoState copyWith({
    List<Todo>? todos,
  bool? isLoad,
  }){
    return TodoState(
        isLoad: isLoad ?? this.isLoad,
        todos: todos ?? this.todos
    );
  }

}
class Todo{
  String label;
 Todo({required this.label});
}




final todoProvider = StateNotifierProvider<TodoProvider, TodoState>((ref) => TodoProvider(TodoState.initState()));

class TodoProvider extends StateNotifier<TodoState>{
  TodoProvider(super.state);


 void addTodo(Todo todo) async{
   state = state.copyWith(isLoad: true);
   await Future.delayed(Duration(seconds: 3));

  state = state.copyWith(
    isLoad: false,
    todos: [...state.todos, todo]
  );
 }

  void removeTodo(Todo todo){
    // state.remove(todo);
    // state = [...state];
  }


  void updateTodo(Todo todo, label){
    //  todo.label = label;
    // state = [...state];
  }


}
