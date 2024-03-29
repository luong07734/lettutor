import 'package:flutter/material.dart';
import 'package:lettutor/constants/asset_manager.dart';
import 'package:lettutor/constants/filter.dart';
import 'package:lettutor/data/provider/tutor_provider.dart';
import 'package:lettutor/ultilities/routes.dart';
import 'package:lettutor/view/widgets/list_items/custom_chip.dart';
import 'package:lettutor/view/widgets/list_items/tutor_card.dart';
import 'package:lettutor/view/widgets/view_items/texts/profile_description.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class TutorsPage extends StatefulWidget {
  // static String routeName = "/tutors";
  const TutorsPage({super.key});

  @override
  State<TutorsPage> createState() => _TutorsPageState();
}

class _TutorsPageState extends State<TutorsPage> {
  //final bool _showOptions = false;

  final _searchController = TextEditingController(); // Add this line
  // String _searchQuery = '';

  String _selectedSearchOption = 'All';

  // handle load data
  final _scrollController = ScrollController();
  int _selectedIndex = -1;

  @override
  void initState() {
    super.initState();
    print("init tutors called");

    // fetch initial teacher data
    context.read<TutorProvider>().reset();
    context.read<TutorProvider>().loadTutorsInPage();
    // context.read<TutorProvider>().search(" ", 1, false);

    // listen to scroll events to detect when user reaches end of list
    _scrollController.addListener(_onScroll);

    // add listener for text field changes
    _searchController.addListener(() {
      setState(() {
        // _searchQuery = _searchController.text.toLowerCase();
        context
            .read<TutorProvider>()
            .search(_searchController.text.toLowerCase(), 1, false);
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    print("onscroll");
    final provider = context.read<TutorProvider>();
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      // fetch next page of teacher data
      if (_searchController.text.isEmpty &&
          provider.specialities.isEmpty &&
          provider.isVietnamese == null) {
        provider.loadTutorsInPage(page: provider.page + 1);
        print("truong hop tren");
      } else {
        print("load them search data");
        provider.search(_searchController.text.toLowerCase(),
            context.read<TutorProvider>().page + 1, true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchTutorsIn +
                    (_selectedSearchOption),
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    // Display a popup menu of search options
                    String? selectedOption = await showMenu(
                      context: context,
                      position:
                          const RelativeRect.fromLTRB(1000.0, 0, 0.0, 1000.0),
                      items: [
                        AppLocalizations.of(context)!.all,
                        AppLocalizations.of(context)!.vnTutors,
                        AppLocalizations.of(context)!.foreignTutors,
                      ].map((option) {
                        return PopupMenuItem(
                          value: option,
                          child: Text(option),
                        );
                      }).toList(),
                    );

                    if (selectedOption != null) {
                      setState(() {
                        _selectedSearchOption = selectedOption;
                        print(selectedOption);
                        if (selectedOption ==
                            AppLocalizations.of(context)!.vnTutors) {
                          context.read<TutorProvider>().setIsVietnamese(true);
                        } else if (selectedOption ==
                            AppLocalizations.of(context)!.foreignTutors) {
                          context.read<TutorProvider>().setIsVietnamese(false);
                        } else {
                          context.read<TutorProvider>().setIsVietnamese(null);
                        }
                      });
                    }
                  },
                  icon: const Icon(Icons.flag_circle),
                )),
          ),
        ),
        Flexible(
          flex: 1,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: specialitiesList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text(
                    specialitiesList.values.elementAt(index),
                    style: TextStyle(
                      color: _selectedIndex == index ? Colors.white : null,
                    ),
                  ),
                  selected: _selectedIndex == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedIndex = selected ? index : -1;
                    });
                    if (selected) {
                      context.read<TutorProvider>().clearAllSpecs();
                      context.read<TutorProvider>().addSpec(index);
                    } else {
                      context.read<TutorProvider>().clearSpec(index);
                    }
                  },
                  selectedColor: Colors.blue,
                  // labelStyle: const TextStyle(color: Colors.white)
                ),
              );
            },
          ),
        ),
        Flexible(
          flex: 10,
          child: Consumer<TutorProvider>(builder: (context, tutorProvider, _) {
            if (tutorProvider.tutors.isEmpty && !tutorProvider.isLoading) {
              return Center(
                  child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Image.asset(
                      AssetsManager.searchNotFoundImage,
                      width: 160,
                      height: 160,
                    ),
                  ),
                  ProfileDescription(
                      text: AppLocalizations.of(context)!.searchNotFound),
                ],
              ));
            } else if (tutorProvider.isLoading) {
              // show loading indicator while data is being fetched
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                controller: _scrollController,
                itemCount: tutorProvider.tutors.length +
                    ((tutorProvider.hasMoreItems &&
                            tutorProvider.tutors.length >= 3)
                        ? 1
                        : 0),
                itemBuilder: (BuildContext context, int index) {
                  if (index < tutorProvider.tutors.length) {
                    final tutor = tutorProvider.tutors[index];
                    return Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1), // Màu bóng đổ
                            spreadRadius: 1, // Bán kính của bóng đổ
                            blurRadius: 1, // Độ mờ của bóng đổ
                            offset: const Offset(
                                0, 1), // Độ dịch chuyển của bóng đổ
                          ),
                        ],
                      ),
                      // child: TeacherCard(index, context, tutor),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, Routers.TeacherDetail,
                              arguments: {
                                'tutor': tutor,
                              });
                        },
                        child: TutorCard(
                          tutor: tutor,
                          isFavorite: tutorProvider.isFavorite(tutor),
                        ),
                      ),
                    );
                  } else {
                    // show loading indicator at end of list
                    if (tutorProvider.hasMoreItems) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return Container();
                    }
                  }
                },
              );
            }
          }),
        )
      ],
    );
  }
}
