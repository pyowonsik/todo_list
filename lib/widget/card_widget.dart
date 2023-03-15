import 'package:card_list/bloc/card_list_bloc.dart';
import 'package:card_list/bloc/card_list_state.dart';
import 'package:card_list/todo/card_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/card_list_event.dart';

class CardWidget extends StatelessWidget {
  final int index;
  final CardListState state;
  final String listType;
  const CardWidget(
      {super.key,
      required this.index,
      required this.state,
      required this.listType});

  @override
  Widget build(BuildContext context) {
    List<CardModel>? todoListType;
    if (listType == 'all') {
      todoListType = state.cardList;
    }
    if (listType == 'check') {
      todoListType = state.cardList.where((e) => e.isChecked == true).toList();
    }
    if (listType == 'uncheck') {
      todoListType = state.cardList.where((e) => e.isChecked == false).toList();
    }

    return SizedBox(
      height: 50,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Checkbox(
                value: todoListType![index].isChecked,
                onChanged: (value) {
                  context
                      .read<CardListBloc>()
                      .add(CheckCardEvent(time: todoListType![index].time));
                }),
            Text(
              todoListType[index].todo,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
                onPressed: () {
                  context
                      .read<CardListBloc>()
                      .add(RemoveCardEvent(time: todoListType![index].time));
                },
                child: const Text('삭제')),
          ]),
        ),
      ),
    );
  }
}
