import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_hub/models/model/project_company.dart';
import 'package:student_hub/view_models/project_company_viewModel.dart';
import 'package:student_hub/views/browse_project/project_search.dart';
import 'package:student_hub/views/browse_project/project_saved.dart';
import 'package:student_hub/widgets/project_list_widget.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late Future<List<ProjectCompany>> allProjects;
  List<ProjectCompany> filteredProjects = [];
  List<String> suggestions = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
    setState(() {
      allProjects = fetchAllProjects();
    });
  }

  Future<void> _initializeData() async {
    List<ProjectCompany> projects = await fetchAllProjects();
    setState(() {
      // Assuming you're using this in a StatefulWidget
      filteredProjects = projects;
      suggestions = projects.map((project) => project.title!).toList();
    });
  }

  void filterProjects(String query) async {
    final projects = await fetchAllProjects();
    setState(() {
      if (query.isNotEmpty) {
        filteredProjects = projects
            .where((project) =>
                project.title!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      } else {
        filteredProjects = projects;
      }
      updateSuggestions(query);
    });
  }

  void updateSuggestions(String query) async {
    final projects = await fetchAllProjects();
    setState(() {
      if (query.isNotEmpty) {
        final uniqueSuggestions = projects
            .where((project) =>
                project.title!.toLowerCase().contains(query.toLowerCase()))
            .map((project) => project.title!)
            .toSet();
        suggestions = uniqueSuggestions.toList();
      } else {
        suggestions = projects.map((project) => project.title!).toList();
      }
    });
  }

  void showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for projects...',
                        hintStyle: GoogleFonts.poppins(),
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onChanged: (newValue) {
                        filterProjects(newValue);
                        updateSuggestions(newValue);
                      },
                    ),
                    SizedBox(height: 10),
                    if (suggestions.isNotEmpty)
                      Container(
                        constraints: BoxConstraints(maxHeight: 300.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: suggestions.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(suggestions[index]),
                              onTap: () {
                                _searchController.text = suggestions[index];
                                filterProjects(suggestions[index]);
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SearchProject(
                                      searchResults: filteredProjects,
                                      allProjects: filteredProjects,
                                    ),
                                  ),
                                ).then((value) {
                                  _initializeData();
                                });
                              },
                            );
                          },
                        ),
                      )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight + 20),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        showSearchBottomSheet(context);
                      },
                      child: TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          hintText: 'Search for projects...',
                          hintStyle: GoogleFonts.poppins(),
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            //color
                          
                            borderRadius: BorderRadius.circular(50),

                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.bookmark_rounded),
                    color: Color.fromARGB(255, 250, 55, 87),
                    iconSize: 30,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FavoriteProjectsPage(
                            favoriteProjects: filteredProjects
                                .where((project) => project.isFavorite)
                                .toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ProjectList(key: Key('allProjects'), projects: filteredProjects),
          ],
        ),
      ),
    );
  }

  Future<List<ProjectCompany>> fetchAllProjects() async {
    return await ProjectCompanyViewModel(context).getAllProjectsData();
  }
}
