import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sportcred/network/acs_rest_driver.dart';
import 'package:sportcred/network/profile_fetch.dart';
import 'package:sportcred/network/profile_friend_rest_driver.dart';
import 'package:sportcred/profile/acs_page.dart';
import 'package:sportcred/profile/friend.dart';
import 'package:sportcred/profile/profile_edit_page.dart';

import 'package:sportcred/profile/profile_factory.dart';
import 'package:sportcred/sign_in/auth.dart';
import 'package:sportcred/util/util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
//the following variables need to be parsed from database(maybe not username)

class ProfilePage extends StatefulWidget {
  final bool self;
  final int userId;
  final bool isWindow;
  const ProfilePage(
      {Key key, @required this.self, this.userId, this.isWindow = true})
      : super(key: key);
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool loadSuccess;
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  Future<Profile> profileCur;
  final TextStyle _textTitle =
      TextStyle(fontWeight: FontWeight.w400, fontSize: 19);

  final TextStyle _textSub = TextStyle(fontSize: 15, fontFamily: 'AmazonEmber');

  Widget buildFields(String field, String entry, String ans, Icon leading,
      bool editable, BuildContext context) {
    return ListTile(
      onTap: editable
          ? () async {
              await navi(
                  context,
                  ProfileEditPage(
                    entry: entry,
                    oldValue: ans,
                    field: field,
                  ));

              // updateThings
              setState(() {
                loadProfileData();
              });
            }
          : () {},
      leading: leading,
      title: Text(
        entry,
        style: _textTitle,
      ),
      subtitle: Text(
        ans,
        style: _textSub,
      ),
      trailing: editable ? Icon(Icons.chevron_right) : null,
    );
  }

  Widget buildFieldEdit(String fields, TextEditingController controller,
      TextStyle _q, TextStyle _a,
      [bool isNumber = false]) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
              left: 20,
            ),
            child: Text(fields, style: _q),
          ),
        ),
        Expanded(
          child: Container(
              margin: EdgeInsets.only(right: 20),
              child: TextField(
                keyboardType:
                    isNumber ? TextInputType.number : TextInputType.text,
                controller: controller,
                style: _a,
                textAlign: TextAlign.end,
              )),
        ),
      ],
    );
  }

  Widget getUserSpecificWidget(Profile profile) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.timeline),
          title: Text(
            "ACS SCORE",
            style: _textTitle,
          ),
          subtitle: Text(
            '${profile.acsPoint}',
            style: _textSub,
            // textAlign: TextAlign.center,
          ),
          trailing: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              onChanged: (String page) async {
                ACSInfoList list = await ACSRestDriver.instance
                    .getACSInfoListAll(Auth.instance.userId, page);
                navi(context, ACSPage(acsInfoList: list));
              },
              icon: Icon(Icons.chevron_right),
              items: <String>[
                'Overall',
                'Participation',
                'Debate and Analyze',
                'Trivia',
                'Picks and Prediction'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  child: Text(
                    value,
                    style: _textSub,
                  ),
                  value: value,
                );
              }).toList(),
            ),
          ),
        ),
        ListTile(
          leading: Icon(Icons.assistant_photo_rounded),
          trailing: Icon(Icons.chevron_right),
          onTap: () => navi(
              context,
              FriendView(
                profile: profile,
              )),
          title: Text(
            "Radar",
            style: _textTitle,
          ),
        ),
      ],
    );
  }

  Widget avatarEditBottomSheet(String url) {
    return Container(
      color: Colors.deepOrangeAccent,
      width: MediaQuery.of(context).size.width,
      height: 90,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: <Widget>[
          Text("Choose Profile photo"),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.camera),
                  onPressed: () async {
                    final pickedFile =
                        await _picker.getImage(source: ImageSource.camera);

                    _imageFile = pickedFile;

                    ProfileRestDriver.instance
                        .putProfileAvatar(_imageFile.path);
                    CachedNetworkImage.evictFromCache(url);
                    setState(() {
                      loadProfileData();
                    });
                    Navigator.pop(context, true);
                  }),
              IconButton(
                  icon: Icon(Icons.image),
                  onPressed: () async {
                    PaintingBinding.instance.imageCache.clear();
                    final pickedFile =
                        await _picker.getImage(source: ImageSource.gallery);

                    _imageFile = pickedFile;

                    ProfileRestDriver.instance
                        .putProfileAvatar(_imageFile.path);
                    CachedNetworkImage.evictFromCache(url);
                    setState(() {
                      loadProfileData();
                    });
                    Navigator.pop(context, true);
                  })
            ],
          ),
        ],
      ),
    );
  }

  Widget getBio(Profile profile) {
    return ListTile(
        leading: Icon(Icons.person),
        title: Text(
          "Bio",
          style: _textTitle,
        ),
        subtitle: Text(
          "${profile.bio}",
          style: _textSub,
          // textAlign: TextAlign.center,
        ));
  }

  void loadProfileData() {
    try {
      profileCur = loadJsonProfile(!widget.self ? widget.userId : -1);

      loadSuccess = true;
    } catch (e) {
      loadSuccess = false;
    }
  }

  @override
  void initState() {
    super.initState();
    loadProfileData();
  }

  final TextStyle _username = TextStyle(
      fontWeight: FontWeight.w300, fontSize: 26, fontFamily: 'AmazonEmber');

  // return FlatButton.icon(
  //   // height: double.infinity,
  //   // onTap: () {},
  //   onPressed: () {  },
  //   label: Text(
  //     "Follow",
  //     style: TextStyle(
  //       fontFamily: 'AmazonEmber',
  //       fontWeight: FontWeight.w300,
  //       fontSize: 24
  //     ),
  //     textAlign: TextAlign.center,
  //   ),
  //   icon: Icon(Icons.add_a_photo),
  // child: Text(
  //   "Follow",
  //   style: TextStyle(
  //     fontFamily: 'AmazonEmber',
  //     fontWeight: FontWeight.w300,
  //     fontSize: 24
  //   ),
  //   textAlign: TextAlign.center,
  // ),

  @override
  Widget build(context) {
    // bool result = false;
    // final SnackBar snackbarSuccess = SnackBar(
    //   content: Text('yes'),
    //   elevation: 20,
    // );
    // final SnackBar snackbarVisitor =
    //     SnackBar(content: Text("Welcome to my profile Visitor"), elevation: 20);
    if (!loadSuccess) {
      return Center(
        child: Text('loading failed'),
      );
    }
    return FutureBuilder(
        future: profileCur,
        builder: (context, AsyncSnapshot<Profile> snapshot) {
          if (snapshot.hasData) {
            Profile profile = snapshot.data;

            return Scaffold(
                appBar: widget.isWindow
                    ? AppBar(
                        title: amazonize("${profile.username}"),
                        centerTitle: true,
                      )
                    : null,
                body: ListView(children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(height: 40),
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 90,
                          child: Stack(
                            children: <Widget>[
                              GestureDetector(
                                // child: CircleAvatar(
                                //   backgroundImage: NetworkImage(
                                //       getImageEndpoint(profile.avatarUrl)),
                                //   maxRadius: 80,
                                //   minRadius: 60,
                                // ),
                                child: CachedNetworkImage(
                                  imageUrl: getImageEndpoint(profile.avatarUrl),
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                                onTap: widget.self
                                    ? () async {
                                        var t = showModalBottomSheet(
                                            context: context,
                                            builder: (context) {
                                              return avatarEditBottomSheet(
                                                  getImageEndpoint(
                                                      profile.avatarUrl));
                                            });
                                        setState(() {
                                          CachedNetworkImage.evictFromCache(
                                              getImageEndpoint(
                                                  profile.avatarUrl));
                                          profile.avatarUrl.endsWith('#')
                                              ? profile.avatarUrl =
                                                  profile.avatarUrl.substring(
                                                      0,
                                                      profile.avatarUrl.length -
                                                          1)
                                              : profile.avatarUrl += '#';
                                        });

                                        // setState(() {
                                        //   profile.avatarUrl.endsWith('#')
                                        //       ? profile.avatarUrl =
                                        //           profile.avatarUrl.substring(
                                        //               0,
                                        //               profile.avatarUrl.length -
                                        //                   1)
                                        //       : profile.avatarUrl += '#';
                                        // });
                                      }
                                    : () {},
                              ),
                              Positioned(
                                  top: -8,
                                  right: -8,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 3),
                                    decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text(
                                      "ACS\n${profile.acsPoint}",
                                      style: TextStyle(
                                          color: Colors.deepOrangeAccent,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ))
                            ],
                            overflow: Overflow.visible,
                          ),
                        ),
                        Container(height: 4),
                        widget.isWindow
                            ? Container(height: 20)
                            : Text(
                                "${profile.username}",
                                textAlign: TextAlign.center,
                                style: _username,
                              ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 8,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        if (widget.self)
                          getUserSpecificWidget(profile)
                        else
                          Flex(direction: Axis.horizontal, children: [
                            Expanded(
                                child: Material(
                                    child: InkWell(
                              onTap: profile.followed
                                  ? () {
                                      try {
                                        ProfileRestDriver.instance
                                            .deleteFollow(widget.userId);
                                        setState(() {
                                          profile.followed = false;
                                        });
                                      } catch (e) {}
                                    }
                                  : () {
                                      try {
                                        ProfileRestDriver.instance
                                            .postFollow(widget.userId);
                                        setState(() {
                                          profile.followed = true;
                                        });
                                      } catch (e) {}
                                    },
                              child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  alignment: Alignment.center,
                                  child: profile.followed
                                      ? Text("On Radar",
                                          style: TextStyle(
                                              fontFamily: 'AmazonEmber',
                                              fontWeight: FontWeight.w300,
                                              fontSize: 26))
                                      : Text("Put On Radar",
                                          style: TextStyle(
                                              fontFamily: 'AmazonEmber',
                                              fontWeight: FontWeight.w300,
                                              fontSize: 26))),
                            )))
                          ])
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey.withOpacity(0.3),
                    height: 8,
                  ),
                  // getBio(profile),
                  buildFields('bio', 'Bio', profile.bio, Icon(Icons.person),
                      widget.self, context),
                  Container(
                    color: Colors.grey.withOpacity(0.3),
                    height: 8,
                  ),
                  buildFields(
                      'favoriteSport',
                      "Favorite Sports",
                      profile.favSport,
                      Icon(Icons.sports_basketball),
                      widget.self,
                      context),
                  buildFields(
                      'wantToKnowSport',
                      "Want to Know Sports",
                      profile.wantToKnowSport,
                      Icon(Icons.sports),
                      widget.self,
                      context),
                  buildFields(
                      'favoriteSportTeam',
                      "Favorite Team",
                      profile.favoriteSportTeam,
                      Icon(Icons.sports),
                      widget.self,
                      context),
                  buildFields(
                      'levelOfSportPlay',
                      "Level Of Sports Play",
                      profile.levelOfSportPlay,
                      Icon(Icons.sports),
                      widget.self,
                      context)
                ]));
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
