import 'package:flutter/material.dart';
import 'package:learning_space/services/auth_service.dart';
import 'package:learning_space/views/app/dashboard/tabs/infoBooth/info_booth.dart';
import 'package:learning_space/views/app/dashboard/tabs/myClasses/my_classes.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => _Dashboard();
}

class _Dashboard extends State<Dashboard>{
  dynamic userDetails;
  @override
  void initState() {
    super.initState();
    getLocalData();
  }

  void getLocalData() async {
    userDetails = await AuthService().getDecodedToken();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: Text("test"),
        ),
        appBar: AppBar(
            title: Text("Learning Space"),
            centerTitle: true,
            elevation: 0,
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 90),
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: EdgeInsets.only(left:15, right: 15, bottom: 15),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(
                                      userDetails['claims']['photo']
                                  ),
                                  radius: 20,
                                ),
                                SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(userDetails?['claims']?['fullName'] ?? 'User', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),),
                                    Text(userDetails?['claims']?['username'] ?? '-', style: TextStyle(color: Colors.white),)
                                  ],
                                )
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await AuthService().logout();
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                )
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.logout, color: Colors.white,),
                                  Text("Logout", style: TextStyle(color: Colors.white),)
                                ],
                              ),
                            )
                          ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: TabBar(
                      padding: EdgeInsets.only(left: 15, right: 15),
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Colors.white,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                          color: Colors.white,
                      ),
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.dashboard_outlined),
                              Text(" Info Booth",)
                            ],
                          ),
                        ),
                        Tab(child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.menu_book_outlined),
                            Text(" My Classes",)
                          ],
                        ),)
                      ],
                    ),
                  )
                ],
              )
            )

          // PreferredSize(
          //   child: Container(
          //     child: Column(
          //       children: [
          //         Text("Username")
          //       ],
          //     ),
          //   ),
          //   preferredSize: Size.fromHeight(30),
          // ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15),
          child: TabBarView(
            children: [
              InfoBooth(),
              MyClasses()
            ],
          ),
        )
      ),
    );
  }

}