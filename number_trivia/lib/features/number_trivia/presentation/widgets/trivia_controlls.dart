import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia_event.dart';

class TriviaControlls extends StatefulWidget {
  const TriviaControlls({
    Key key,
  }) : super(key: key);

  @override
  _TriviaControllsState createState() => _TriviaControllsState();
}

class _TriviaControllsState extends State<TriviaControlls> {
  String inputString = '';
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
            if (inputString.isNotEmpty) {
              getConcreteNumberTrivia();
            }
          },
          onChanged: (val) {
            setState(() => inputString = val);
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
                onPressed:
                    inputString.isNotEmpty ? getConcreteNumberTrivia : null,
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
    BlocProvider.of<NumberTriviaBloc>(context).dispatch(
      GetTriviaForConcreteNumber(inputString),
    );
    textController.clear();
    setState(() {
      inputString = '';
    });
  }

  void getRandomNumberTrivia() {
    BlocProvider.of<NumberTriviaBloc>(context).dispatch(
      GetTriviaForRandomNumber(),
    );
    textController.clear();
    setState(() {
      inputString = '';
    });
  }
}
