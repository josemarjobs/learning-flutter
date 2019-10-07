import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:photogram/models/user.dart';
import 'package:photogram/pages/home.dart';
import 'package:photogram/widgets/progress.dart';

class EditProfile extends StatefulWidget {
  final String currentUserId;

  const EditProfile({this.currentUserId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  User user;

  bool _displayNameValid = true;
  bool _bioValid = true;

  TextEditingController displayNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });

    DocumentSnapshot doc = await usersRef.document(widget.currentUserId).get();
    user = User.fromDocument(doc);
    displayNameController.text = user.displayName;
    bioController.text = user.bio;
    setState(() {
      isLoading = false;
    });
  }

  buildDisplayNameField() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: Text(
            "Display Name",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: displayNameController,
          decoration: InputDecoration(
            hintText: "Update display name",
            errorText: _displayNameValid ? null : "Display name too short",
          ),
        )
      ],
    );
  }

  buildBioField() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(
            "Bio",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          controller: bioController,
          decoration: InputDecoration(
            hintText: "Update bio",
            errorText: _bioValid ? null : "Bio too long",
          ),
        )
      ],
    );
  }

  updateProfileData() {
    setState(() {
      _displayNameValid = displayNameController.text.trim().length > 3;
      _bioValid = bioController.text.trim().length < 100;
    });

    if (!_displayNameValid || !_bioValid) {
      return;
    }

    usersRef.document(widget.currentUserId).updateData({
      "displayName": displayNameController.text,
      "bio": bioController.text,
    });

    final SnackBar snackBar = SnackBar(content: Text("Profile Updated!"));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  logout() async {
    await googleSignin.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Home();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.done,
              size: 30.0,
              color: Colors.green,
            ),
          )
        ],
      ),
      body: isLoading
          ? circularProgress()
          : ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage: CachedNetworkImageProvider(
                            user.photoUrl,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            buildDisplayNameField(),
                            buildBioField(),
                          ],
                        ),
                      ),
                      RaisedButton(
                        onPressed: updateProfileData,
                        child: Text(
                          "Update Profile",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: FlatButton.icon(
                          onPressed: logout,
                          icon: Icon(Icons.cancel, color: Colors.red),
                          label: Text(
                            "Logout",
                            style: TextStyle(color: Colors.red, fontSize: 20.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
