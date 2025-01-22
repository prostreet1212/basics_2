import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_bloc.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Codegen'),
      ),
      body: const Center(
        child: _CounterText(),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () =>
              context.read<CounterBloc>().add(CounterEvent.increment()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 20),
          FloatingActionButton(
            onPressed: ()=> context.read<CounterBloc>().add(CounterEvent.reset()),
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}

class _CounterText extends StatelessWidget {
  const _CounterText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CounterBloc>().state;
    return state.when(
        initial: ()=> FlutterLogo(size: 100,),
        loading: (){
          int a=1+1;
          print(a);
          return CircularProgressIndicator();
        },
        loaded: (counter)=>Text('${counter}', style: Theme.of(context).textTheme.displayMedium));

   /* if(state is CounterInitialState){
      return FlutterLogo(size: 100,);
    }else if(state is CounterLoadingState){
      return CircularProgressIndicator();
    }else if(state is CounterLoadedState){
      return Text('${state.counter}', style: Theme.of(context).textTheme.displayMedium);
    }
    return SizedBox.shrink();*/


  }
}