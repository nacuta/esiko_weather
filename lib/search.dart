import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:testingbloc/constants.dart';

class SearchBarAnimated extends StatefulWidget {
  const SearchBarAnimated({super.key});

  @override
  State<SearchBarAnimated> createState() => _SearchBarAnimatedState();
}

class _SearchBarAnimatedState extends State<SearchBarAnimated>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animation = Tween<double>(
      begin: 20,
      end: 35,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    bool isSearch = false;
    return Scaffold(
      body: SizedBox(
        height: 400,
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  top: 20,
                  child: Icon(Icons.abc_outlined),
                ),
                Positioned(
                  top: 20,
                  left: MediaQuery.of(context).size.width * 0.1,
                  child: Icon(Icons.abc_outlined),
                ),
                Positioned(
                  top: 20,
                  left: MediaQuery.of(context).size.width * 0.3,
                  child: Text("data"),
                ),
                Icon(Icons.abc_outlined),
                Text("data"),
                Positioned(top: 10, right: 10, child: SearchBar()),
                SearchBar(),

                // AnimatedPositioned(
                //   duration: Duration(milliseconds: 2000),
                //   child: AnimSearchBar(
                //     textController: textController,
                //     onSuffixTap: () {
                //       setState(() {
                //         textController.clear();
                //       });
                //     },
                //     width: 400,
                //     // color: Colors.transparent,
                //     helpText: "Search Text...",
                //     autoFocus: true,
                //     closeSearchOnSuffixTap: true,
                //     animationDurationInMilli: 2000,
                //     rtl: true,
                //   ),
                // )
              ],
            )
            // AnimatedBuilder(
            //   animation: _controller,
            //   builder: ((context, child) {
            //     return IconButton(
            //       onPressed: () {},
            //       icon: Icon(Icons.search),
            //     );
            //   }),
            //   // child: IconButton(
            //   //   onPressed: () {},
            //   //   icon: Icon(Icons.search),
            //   // ),
            // ),
          ],
        ),
      ),
    );
  }
}

class SearchBar extends StatefulWidget with PreferredSizeWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchBarState extends State<SearchBar> {
  bool _toggle = true;

  void _doToggle() => setState(() => _toggle = !_toggle);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: _doToggle,
        child: SizedBox(
            height: kToolbarHeight * 0.8,
            child: _toggle
                ? Icon(
                    Icons.search,
                    size: 24.0,
                    color: kPrimaryColor,
                  )
                : Container()),
      ),
      AnimatedContainer(
        width: _toggle ? 0 : MediaQuery.of(context).size.width,
        transform: Matrix4.translationValues(
            _toggle ? MediaQuery.of(context).size.width : 0, 0, 0),
        duration: const Duration(seconds: 1),
        height: kToolbarHeight * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 1,
            color: Colors.grey[600]!,
          ),
        ),
        child: TextField(
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  icon: const Icon(Icons.search), onPressed: _doToggle),
              prefixIcon: AnimatedOpacity(
                  duration: const Duration(seconds: 1),
                  opacity: _toggle ? 0 : 1,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: _doToggle,
                  )),
              border: InputBorder.none),
        ),
      )
    ]);
  }
}

class SearchAppBarWidget extends StatefulWidget with PreferredSizeWidget {
  const SearchAppBarWidget({super.key});

  @override
  State<SearchAppBarWidget> createState() => _SearchAppBarWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarWidgetState extends State<SearchAppBarWidget> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search city";
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _isSearching
          ? const BackButton()
          : Icon(
              Icons.more_vert_outlined,
              color: kPrimaryColor,
            ),
      title: _isSearching
          ? _buildSearchField()
          : Text(
              'Arad',
              style: TextStyle(
                  color: Colors.deepPurple.shade700,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
      actions: _buildActions(),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Search Data...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: kPrimaryColor),
      ),
      style: TextStyle(color: kPrimaryColor, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: Icon(
            Icons.clear,
            color: kPrimaryColor,
          ),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.search,
          color: kPrimaryColor,
        ),
        onPressed: _startSearch,
      ),
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
