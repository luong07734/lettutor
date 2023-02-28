import 'package:flutter/material.dart';

import '../../../constants/asset_manager.dart';
import '../../../constants/fake_data.dart';

Card TeacherCard(int index) {
  return Card(
    child: Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(AssetsManager.avatarImage),
          ),
          title: Text(myData[index]['name'].toString()),
          subtitle: Row(
            children: [
              const Icon(Icons.star, color: Colors.yellow),
              Text(myData[index]['rating'].toString()),
            ],
          ),
          trailing: TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
            label: const Text('Like'),
          ),
        ),
        Wrap(
          spacing: 4.0,
          children: List.generate(6, (chipIndex) {
            return Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Chip(
                label: Text('Chip $chipIndex'),
                backgroundColor: Colors.amber,
              ),
            );
          }),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          child: Text(
            myData[index]['description'].toString(),
            textAlign: TextAlign.start,
            maxLines: 4,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
