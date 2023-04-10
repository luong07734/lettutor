import 'package:flutter/material.dart';
import 'package:lettutor/constants/filter.dart';
import 'package:lettutor/data/network/apis/tutors/tutor_apis.dart';
import 'package:lettutor/models/tutor.dart';

class TutorProvider extends ChangeNotifier {
  final TutorApis _tutorApis = TutorApis();
  List<TutorRowItem> _tutors = [];
  List<TutorRowItem> _baseTutors = [];
  List<FavoriteTutor> _favorites = [];
  int _page = 1;
  int _searchPage = 1;
  bool _hasMoreItems = true;
  List<String> _specialities = [];
  String keySearch = "";

  List<TutorRowItem> get tutors => _tutors;
  List<FavoriteTutor> get favorites => _favorites;
  int get page => _page;
  bool get hasMoreItems => _hasMoreItems;
  List<String> get specialities => _specialities;
  int get searchPage => _searchPage;

  bool isFavorite(TutorRowItem tutor) {
    bool isFavorite = false;
    print(_favorites);
    for (int i = 0; i < _favorites.length; i++) {
      if (_favorites[i].secondId == tutor.userId) {
        print(i);
        isFavorite = true;
      }
    }

    print(isFavorite);
    return isFavorite;
  }

  void loadTutorsInPage({int page = 1}) {
    _page = page;

    _tutorApis.getTutorList(page).then((tutors) {
      print("getting...");
      int oldLength = _tutors.length;
      if (tutors["tutors"] != null) {
        print("load dc");
        TutorPerPage _tutorsPerPage = TutorPerPage.fromJson(tutors);
        _tutors += _tutorsPerPage.tutors.rows;
        _baseTutors += _tutorsPerPage.tutors.rows;

        _favorites = _tutorsPerPage.favoriteTutor == null
            ? []
            : _tutorsPerPage.favoriteTutor!;
        print("favorites ${_favorites}");

        print("length of tutors: ${_tutors.length}");
        if (_tutors.length > oldLength) {
          _hasMoreItems = true;
        } else {
          _hasMoreItems = false;
        }
      } else {}
      notifyListeners();
    });
  }

  void updateFavorite(String tutorId) {
    _tutorApis.addATutorToFavouriteList(tutorId);
    _tutorApis.getTutorList(page).then((tutors) {
      TutorPerPage _tutorsPerPage = TutorPerPage.fromJson(tutors);
      _favorites = _tutorsPerPage.favoriteTutor == null
          ? []
          : _tutorsPerPage.favoriteTutor!;
    });
    notifyListeners();
  }

  void search(String value, int page, bool isScrolled) {
    _searchPage = page;
    print("searching .....");
    keySearch = value;
    if (value.isEmpty && _specialities.isEmpty) {
      print("reloading...");
      keySearch = "";
      _tutors.clear();
      _specialities.clear();
      loadTutorsInPage(page: 1);

      notifyListeners();
      return;
    }
    var listKeySpec = <String>[];
    for (var i in specialitiesList.keys) {
      if (_specialities.contains(i)) {
        listKeySpec.add(i);
      }
    }
    print("list key spec ${listKeySpec}");

    _tutorApis
        .searchTutor(
            page: page,
            value,
            specialties: listKeySpec.isEmpty ? null : listKeySpec)
        .then((value) {
      Tutors tutors = Tutors.fromJson(value);
      int oldLength = _tutors.length;

      if (isScrolled) {
        _tutors += tutors.rows;
      } else {
        _tutors.clear();
        _tutors = tutors.rows;
        print("${tutors.rows}");
      }
      if (_tutors.length > oldLength) {
        _hasMoreItems = true;
      } else {
        _hasMoreItems = false;
      }

      notifyListeners();
    });
  }

  void reset() {
    _tutors = [];
    _hasMoreItems = true;
    _page = 1;
  }

  void addSpec(int index) {
    // if (index == 0) {
    //   _specialities.clear();
    // } else {
    _specialities.add(specialitiesList.keys.elementAt(index));
    // }

    search(keySearch, 1, false);
    print(_specialities);
  }

  void clearSpec(int index) {
    // if (index == 0) {
    // } else {
    _specialities.remove(specialitiesList.keys.elementAt(index));
    // }

    search(keySearch, 1, false);
    print(_specialities);
  }
}
