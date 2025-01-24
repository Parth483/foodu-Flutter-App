import 'package:flutter/material.dart';

class Favourite extends StatefulWidget {
  const Favourite({super.key});
  static const favourite = 'favourite';

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  bool _isSearchVisible = false;

  final List<int> _list = [
    1,
    2,
    3,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
            padding: EdgeInsets.only(left: 20), child: Text('Favourites')),
        titleSpacing: 0,
        toolbarHeight: 70,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isSearchVisible = true;
                });
              },
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          if (_isSearchVisible)
            Row(
              children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(8),
                          child: Icon(Icons.search),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(26, 185, 178, 178),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isSearchVisible = false;
                    });
                  },
                  child: Text('Cancel'),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          SizedBox(
            height: 20,
          ),
          Flexible(
            child: Center(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            'Item ${_list[index]}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    })),
          ),
        ],
      ),
    );
  }
}
