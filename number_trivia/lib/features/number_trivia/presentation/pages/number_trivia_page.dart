import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/widgets.dart';

import '../../../../injection_container.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (context) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10.0),
              //* top half: output area
              buildOutputArea(context),
              SizedBox(height: 20.0),
              //* bottom half: input area
              buildInputArea(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputArea(BuildContext context) {
    return TriviaControlls();
  }

  Widget buildOutputArea(BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        if (state is Empty) {
          return MessageDisplay(message: 'Start Searching');
        } else if (state is Error) {
          return MessageDisplay(message: state.message);
        } else if (state is Loading) {
          return LoadingWidget();
        } else if (state is Loaded) {
          return TriviaDisplay(numberTrivia: state.numberTrivia);
        }
        return Text('Something went wrong');
      },
    );
  }
}

