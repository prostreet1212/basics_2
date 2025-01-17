import 'package:basics_2/theme13/common/app_colors.dart';
import 'package:basics_2/theme13/features/domain/entities/person_entity.dart';
import 'package:basics_2/theme13/features/presentation/widgets/person_cache_image_widget.dart';
import 'package:flutter/material.dart';

import '../pages/person_detail_screen.dart';

class PersonCard extends StatelessWidget {
  final PersonEntity person;

  const PersonCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonDetailPage(person: person,)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cellBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
           PersonCacheImage(
             width:166 ,
             height:166 ,
               imageUrl: '${person.image}'),
            SizedBox(
              width: 16,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 12,
                ),
                Text(
                  person.name,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          color: person.status == 'Alive'
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        '${person.status} - ${person.species}',
                        style: TextStyle(color: Colors.white),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Last known location:',
                  style: TextStyle(color: AppColors.greyColor),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${person.location.name}',
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Origin:',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${person.origin.name}',
                  style: TextStyle(color: Colors.white),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
            ),
            SizedBox(width: 12,)
          ],
        ),
      ),
    );
  }
}
