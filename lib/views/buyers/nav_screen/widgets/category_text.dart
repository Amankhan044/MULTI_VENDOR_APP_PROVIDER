import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  final List<String> _categoryLabel = [
    'food',
    'vegetable',
    'egg',
    'tea',
    'food',
    'vegetable',
    'egg',
    'tea'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: TextStyle(fontSize: 19),
          ),
          Container(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categoryLabel.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ActionChip(
                          side: BorderSide.none,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.yellow.shade900,
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          onPressed: () {},
                          label: Text(
                            _categoryLabel[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
