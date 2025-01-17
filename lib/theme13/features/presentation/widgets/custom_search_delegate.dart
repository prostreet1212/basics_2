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
  bool firstRun=true;

  void setupScrollSearchController(BuildContext context,String personQuery,int page) {
    context.read<PersonSearchBloc>().add(SearchPersons(personQuery,page));
    scrollSearchController.addListener(() {
      if (scrollSearchController.position.atEdge) {
        if (scrollSearchController.position.pixels != 0) {
          context.read<PersonSearchBloc>().add(SearchPersons(personQuery,page));
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
    /*bool first=true;
    if(first==true){
      context.read<PersonSearchBloc>().add(SearchPersons(query));
      setupScrollSearchController(context,query);
      first=false;
    }else{*/
      setupScrollSearchController(context,query,1);
    //}

    //BlocProvider.of<PersonSearchBloc>(context,listen: false)..add(SearchPersons(query));
    //print('inside custom search delegate and search query is $query');
   return BlocBuilder<PersonSearchBloc,PersonSearchState>(
       builder: (context,state){
          if(state is PersonSearchLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is PersonSearchLoaded){
            final persons=state.persons;
            if(persons.isEmpty){
              return _showErrorText('Characters not found');
            }

            return Container(
              child: ListView.builder(
                controller: scrollSearchController,
                itemCount:persons.isNotEmpty?persons.length:0,
                  itemBuilder: (context,index){
                  PersonEntity result=persons[index];
                  return SearchResult(personResult: result);
                  }),
            );
          }else if(state is PersonSearchError){
            return _showErrorText(state.message);
          }else{
            return Center(
              child: Icon(
                Icons.now_wallpaper),
            );
          }
       });
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