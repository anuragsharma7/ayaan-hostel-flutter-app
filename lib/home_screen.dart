import 'dart:math';

import 'package:anayahostelapp/UserTabBar';
import 'package:anayahostelapp/constant/colors.dart';
import 'package:anayahostelapp/edit.dart';
import 'package:anayahostelapp/model/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:anayahostelapp/UserTabBar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> filteredNotes = [];
  bool sorted = false;

  @override
  void initState() {
    super.initState();
    filteredNotes = sampleNotes;
  }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredNotes =
          sampleNotes
              .where(
                (note) =>
                    (note.content?.toLowerCase() ?? "").contains(
                      searchText.toLowerCase(),
                    ) ||
                    (note.title?.toLowerCase() ?? "").contains(
                      searchText.toLowerCase(),
                    ),
              )
              .toList();
    });
  }

  void deleteNote(int index) {
    setState(() {
      Note note = filteredNotes[index];
      sampleNotes.remove(note);
      filteredNotes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 164, 205, 236),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 5, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Students List',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      // filteredNotes = sortNotesByModifiedTime(filteredNotes);
                    });
                  },
                  padding: const EdgeInsets.all(0),
                  icon: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800.withOpacity(.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.sort, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              onChanged: onSearchTextChanged,
              style: const TextStyle(fontSize: 16, color: Colors.black),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                hintText: "Search students...",
                hintStyle: const TextStyle(color: Colors.black),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                // : Colors.grey.shade800,
                fillColor: const Color.fromARGB(
                  255,
                  202,
                  242,
                  207,
                ), //green color

                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 30),
                itemCount: filteredNotes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    // color: getRandomColor(),
                    color: const Color.fromARGB(
                      255,
                      202,
                      242,
                      207,
                    ), //green Card bg color
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ListTile(
                        onTap: () async {
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => UserTabBar(note: filteredNotes[index]),

                              // EditScreen(note: filteredNotes[index]),
                            ),
                          );
                          if (result != null) {
                            setState(() {
                              int originalIndex = sampleNotes.indexOf(
                                filteredNotes[index],
                              );

                              sampleNotes[originalIndex] = Note(
                                id: sampleNotes[originalIndex].id,
                                title: result[0],
                                content: result[1],
                                modifiedTime: DateTime.now(),
                              );

                              filteredNotes[index] = Note(
                                id: filteredNotes[index].id,
                                title: result[0],
                                content: result[1],
                                modifiedTime: DateTime.now(),
                              );
                            });
                          }
                        },
                        title: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: '${filteredNotes[index].title} \n',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              height: 1.5,
                            ),
                            children: [
                              TextSpan(
                                text: filteredNotes[index].content,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            'Edited: ${DateFormat('EEE MMM d, yyyy h:mm a').format(filteredNotes[index].modifiedTime ?? DateTime(1970, 1, 1))}',
                            style: TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),

                        // Delete icon
                        trailing: IconButton(
                          onPressed: () async {
                            final result = await confirmDialog(context);
                            if (result != null && result) {
                              deleteNote(index);
                            }
                          },
                          icon: const Icon(Icons.delete),
                        ),

                        leading: CircleAvatar(
                          backgroundImage:
                              Image.asset(
                                'images/user.png',
                              ).image, // No matter how big it is, it won't overflow
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const EditScreen(),
            ),
          );

          if (result != null) {
            setState(() {
              sampleNotes.add(
                Note(
                  id: sampleNotes.length,
                  title: result[0],
                  content: result[1],
                  modifiedTime: DateTime.now(),
                ),
              );
              filteredNotes = sampleNotes;
            });
          }
        },
        elevation: 10,
        backgroundColor: Colors.grey.shade800,
        child: const Icon(Icons.add, size: 38),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade900,
          icon: const Icon(Icons.info, color: Colors.grey),
          title: const Text(
            'Are you sure you want to delete?',
            style: TextStyle(color: Colors.white),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const SizedBox(
                  width: 60,
                  child: Text(
                    'Yes',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const SizedBox(
                  width: 60,
                  child: Text(
                    'No',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
