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
      body: buildBody(context),
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

class TriviaControlls extends StatefulWidget {
  const TriviaControlls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControllsState createState() => _TriviaControllsState();
}

class _TriviaControllsState extends State<TriviaControlls> {
  String inputString;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input a number',
          ),
          keyboardType: TextInputType.number,
          onSubmitted: (val) {
            inputString = val;
            getConcreteNumberTrivia();
          },
          onChanged: (val) {
            inputString = val;
          },
        ),
        SizedBox(height: 10.0),
        Row(
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                child: Text('Search'),
                color: Theme.of(context).accentColor,
                textTheme: ButtonTextTheme.primary,
                onPressed: getConcreteNumberTrivia,
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: RaisedButton(
                child: Text('Get Random Trivia'),
                onPressed: getRandomNumberTrivia,
              ),
            )
          ],
        )
      ],
    );
  }

  void getConcreteNumberTrivia() {
    textController.clear();
    BlocProvider.of<NumberTriviaBloc>(context).dispatch(
      GetTriviaForConcreteNumber(inputString),
    );
  }

  void getRandomNumberTrivia() {
    textController.clear();
    BlocProvider.of<NumberTriviaBloc>(context).dispatch(
      GetTriviaForRandomNumber(),
    );
  }
}
