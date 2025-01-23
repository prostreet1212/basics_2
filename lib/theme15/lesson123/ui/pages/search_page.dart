import 'dart:async';

import 'package:basics_2/theme15/lesson123/bloc/character_bloc.dart';
import 'package:basics_2/theme15/lesson123/data/models/character.dart';
import 'package:basics_2/theme15/lesson123/ui/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Character _currentCharacter;
  List<Results> _currentResults = [];
  int _currentPage = 1;
  String _currentSearchStr = '';

  final refreshController=RefreshController();
  bool _isPagination=false;

  Timer? searchDebounce;

  final _storage=HydratedBloc.storage;

  @override
  void initState() {
    super.initState();
if(_storage.runtimeType.toString().isEmpty){
  if (
  _currentResults.isEmpty) {
    context
        .read<CharacterBloc>()
        .add(CharacterEvent.fetch(name: '', page: 1));
  }
}

  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharacterBloc>().state;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 15, left: 16, right: 16),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(86, 86, 86, 0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.white),
              hintText: 'Search Name',
              hintStyle: const TextStyle(color: Colors.white),
            ),
            onChanged: (value) {
              _currentPage=1;
              _currentResults=[];
              _currentSearchStr=value;
              searchDebounce?.cancel();
              searchDebounce=Timer(Duration(milliseconds: 500),(){
                context
                    .read<CharacterBloc>()
                    .add(CharacterEvent.fetch(name: _currentSearchStr, page: _currentPage));
              });

            },
          ),
        ),
        Expanded(
          child: state.when(
              loading: () {
                if(!_isPagination){
                  return Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Loading...')
                        ],
                      ));
                }else{
                  return _customListView(_currentResults);
                }

              },
              loaded: (characterLoaded) {
                _currentCharacter=characterLoaded;
                if(_isPagination){
                  _currentResults.addAll(_currentCharacter.results);
                  refreshController.loadComplete();
                  _isPagination=false;
                }else{
                  //первые 20 персонажей
                  _currentResults=_currentCharacter.results;
                }
                return _currentResults.isNotEmpty?_customListView(_currentResults):SizedBox();
              },
              error: () => Text('Nothing found...')),
        ),
      ],
    );
  }
  
  Widget _customListView(List<Results> currentResults){
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: true,
      enablePullDown: false,
      onLoading: (){
        _isPagination=true;
        _currentPage++;
        if(_currentPage<=_currentCharacter.info.pages){
          context.read<CharacterBloc>().add(CharacterEvent.fetch(name: _currentSearchStr, page: _currentPage));
        }else{
          refreshController.loadNoData();
        }
      },
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: currentResults.length,
          itemBuilder: (context,index){
          final result=currentResults[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16,left: 16,top: 3,bottom: 3),
            child: CustomListTile(result: result),
          );
          },
          separatorBuilder: (context,index){
          return SizedBox(height: 5,);
          },
          ),
    );
  }
}
