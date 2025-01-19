import 'dart:async';

import 'package:basics_2/theme13/features/presentation/bloc/person_list_cubit/person_list_state.dart';
import 'package:basics_2/theme13/features/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:basics_2/theme13/features/presentation/bloc/search_bloc/search_event.dart';
import 'package:basics_2/theme13/features/presentation/bloc/search_bloc/search_state.dart';
import 'package:basics_2/theme13/features/presentation/widgets/search_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/person_entity.dart';

class CustomeSearchDelegate extends SearchDelegate{

  CustomeSearchDelegate():super(searchFieldLabel:'Search  for characters...');

  final scrollSearchController = ScrollController();
  //bool firstRun=true;

  void setupScrollSearchController(BuildContext context,String personQuery) {
    context.read<PersonSearchBloc>().add(SearchPersons(personQuery));
    scrollSearchController.addListener(() {
      if (scrollSearchController.position.atEdge) {
        if (scrollSearchController.position.pixels != 0) {
          context.read<PersonSearchBloc>().add(SearchPersons(personQuery));
        }
      }
    });
  }

  final _suggestions=[
    'Rick',
    'Morty',
    'Summer',
    'Betch',
    'Jerry',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query='';
          showSuggestions(context);
        }, )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
  return IconButton(
    icon: Icon(Icons.arrow_back_outlined),
      tooltip: 'Back',
      onPressed: (){
      close(context, null);
      },
     );
  }

  @override
  Widget buildResults(BuildContext context) {
      setupScrollSearchController(context,query);
   return BlocBuilder<PersonSearchBloc,PersonSearchState>(
       builder: (context,state){
         List<PersonEntity> persons = [];
         bool isLoading = false;
          if(state is PersonSearchLoading&& state.isFirstFetch){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PersonSearchLoading) {
            persons = state.oldPersonsList;
            isLoading = true;
          } else if(state is PersonSearchLoaded){
             persons=state.persons;
            if(persons.isEmpty){
              return _showErrorText('Characters not found');
            }
          }else if(state is PersonSearchError){
            return _showErrorText(state.message);
          }
            return   Container(
              child: ListView.builder(
                  controller: scrollSearchController,
                  itemCount: persons.length + (isLoading ? 1 : 0),
                  itemBuilder: (context,index){

                    if (index < persons.length) {
                      PersonEntity result=persons[index];
                      return SearchResult(personResult: result);
                    } else {
                      Timer(const Duration(milliseconds: 30), () {
                        scrollSearchController
                            .jumpTo(scrollSearchController.position.maxScrollExtent);
                      });
                      return _loadingIndicator();
                    }
                  }),
            );

       });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _showErrorText(String errorMessage){
    return Container(
      color: Colors.black,
      child: Center(
        child: Text(errorMessage,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.length>0){
      return Container();
    }
    return ListView.separated(
      padding: EdgeInsets.all(10),
      itemCount: _suggestions.length,
        itemBuilder: (contetx,index){
        return Text(_suggestions[index],
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),);
        },
        separatorBuilder: (contetx,index){
        return Divider();
        },
        );
  }
  
}