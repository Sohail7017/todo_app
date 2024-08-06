import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:to_do_app/database/local/db_helper.dart';

class HomePage extends StatefulWidget{



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

      DbHelper? mainDb;
      List<Map<String,dynamic>> allTasks =[];
  @override
  void initState() {
    super.initState();
    mainDb =  DbHelper.getInstance;
      getInitialTask();
  }
    void  getInitialTask() async{
      allTasks = await mainDb!.getAllTasks();
      setState(() {

      });
      }

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  bool? isChecked = false;

  List imagesList = [
    'assets/images/mahesh.png',
    'assets/images/sherya_ghoshal.jpeg',
    'assets/images/soul.png',
    'assets/images/munawar_faruqui.jpg',

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        leading: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Icon(Icons.menu,size: 30,color: Colors.grey.withOpacity(0.8),),
        ),
        title: Center(child: Text('ToDo App',style: TextStyle(fontSize: 30,color: Colors.purpleAccent.shade400,fontWeight: FontWeight.bold),)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Icon(Icons.notifications,size: 30,color: Colors.black.withOpacity(0.4),),
          )
        ],
      ),
      bottomNavigationBar: Stack(
        children: [Padding(
          padding: const EdgeInsets.only(top: 40),
          child: BottomAppBar(
                child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(Icons.home,size: 40,color: Colors.purpleAccent.shade400,),
            Icon(Icons.bar_chart,size: 40,color: Colors.grey.shade700,),
            SizedBox(
              width: 30,
            ),
            Icon(Icons.message,size: 40,color: Colors.grey.shade700,),
            Icon(Icons.people_alt_rounded,size: 40,color: Colors.grey.shade700,),
          ],
                ),
              ),
        ),
          Padding(
            padding: const EdgeInsets.only(left: 160,bottom: 35),

            /// BottomSheet
            child: InkWell(
              onTap: (){
                showModalBottomSheet(context: context, builder: (_){
                  return Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                        Center(child: Text('Add Task',style: TextStyle(fontSize:  20,color: Colors.purpleAccent.shade400,fontWeight: FontWeight.bold),)),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Tittle',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 2,color: Colors.purpleAccent.shade400)
                            ),
                            child: TextField(
                              controller: titleController,
                              decoration: InputDecoration(
                                hintText: 'Enter your title',
                                hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                                border: OutlineInputBorder(borderSide: BorderSide.none)
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Description',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            height: 130,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 2,color: Colors.purpleAccent.shade400)
                            ),
                            child: TextField(
                              maxLines: 3,
                              controller: descController,
                              decoration: InputDecoration(
                                  hintText: 'Enter your description',
                                  hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                                  border: OutlineInputBorder(borderSide: BorderSide.none)
                              ),
                            ),
                          ),
                              SizedBox(
                                height: 20,
                              ),
                          /// Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [


                              ElevatedButton(onPressed: (){
                                      addTaskInDB();
                                      titleController.clear();
                                      descController.clear();
                                      Navigator.pop(context);
                              }, child: Text('Add',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent.shade400.withOpacity(0.5)),),

                              SizedBox(
                                width: 40,
                              ),

                              ElevatedButton(onPressed: (){
                                      Navigator.pop(context);
                              }, child: Text('Cancel',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent.shade400.withOpacity(0.5)),),

                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
              },
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.purpleAccent.shade400,
                ),
                child: Icon(Icons.add,size: 30,color: Colors.white,weight: 20,),
              ),
            ),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Container(
                  width: 380,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.purpleAccent.shade400
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 22,
                        ),
                        Text("Today's Progress",style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 180,),
                  child: Container(
                    width: 240,
                    height: 200,
                    child: Image(image: AssetImage('assets/icons/todo_logo.png'),fit: BoxFit.fill,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 130,left: 30),
                  child: Container(
                    height: 40,
                    child: Row(

                      children: [
                        Row(
                          children: [
                            for(int i = 0; i<imagesList.length; i++)
                              Align(
                                widthFactor: 0.6,
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundImage: AssetImage(imagesList[i]),
                                  ),
                                ),
                              )
                          ],
                        ),

                        CircleAvatar(
                          backgroundColor: Colors.purpleAccent.shade700,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              Icon(Icons.add,size: 15,color: Colors.white,),
                              Text("2",style: TextStyle(fontSize: 15,color: Colors.white),)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 90,left: 60),
                  child: Container(
                    child: Text('Members',style: TextStyle(fontSize: 20,color: Colors.white.withOpacity(0.8)),),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: 380,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.purpleAccent.shade400,
                borderRadius: BorderRadius.circular(15)
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Icon(Icons.task,size: 50,color: Colors.white,),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Project Task',style: TextStyle(fontSize: 18,color: Colors.white.withOpacity(0.9),fontWeight: FontWeight.bold),),

                        Text('Total 4 Tasks',style: TextStyle(fontSize: 16,color: Colors.white.withOpacity(0.7),fontWeight: FontWeight.bold),),
                      ],
                    ),
                      SizedBox(
                        width: 120,
                      ),
                      Container(
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white.withOpacity(0.3),
                        border: Border.all(width: 2,color: Colors.grey.shade400)
                      ),
                        child: Icon(Icons.keyboard_arrow_down,size: 30,color: Colors.white,),
                      )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Tasks",style: TextStyle(fontSize: 18,color: Colors.purpleAccent.shade400,fontWeight: FontWeight.bold),),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text("See All",style: TextStyle(fontSize: 15,color: Colors.black.withOpacity(0.3),fontWeight: FontWeight.bold),),
                ),
              ],
            ),
            Container(
              child: allTasks.isNotEmpty ? Expanded(
                child: ListView.builder(
                    itemCount: allTasks.length,
                    itemBuilder: (_, index){
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      height: 90,
                      /*width: 380,*/
                      decoration:  BoxDecoration(
                        border: Border.all(width: 2,color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(
                        child: ListTile(

                          leading: SizedBox(
                            width: 70,
                            height: 80,
                            child: Row(
                              children: [
                                Checkbox(value: isChecked,activeColor: Colors.blueAccent, onChanged: (newBool){
                                  setState(() {
                                   isChecked = newBool;
                                  });
                                },),
                                Text('${allTasks[index][DbHelper.tableColumnSNo]}',style: TextStyle(fontSize: 18,color: Colors.grey.shade700),),
                              ],
                            ),
                          ),
                          title: Text(allTasks[index][DbHelper.tableColumntittle],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.purpleAccent.shade200),),
                          subtitle: Text(allTasks[index][DbHelper.tableColumnDesc],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.purpleAccent.shade100),),
                          trailing: SizedBox(
                            width: 65,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: (){
                                      titleController.text = allTasks[index][DbHelper.tableColumntittle];
                                      descController.text = allTasks[index][DbHelper.tableColumnDesc];
                                      showModalBottomSheet(context: context, builder: (_){
                                        return Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Center(child: Text('Update Task',style: TextStyle(fontSize:  28,color: Colors.purpleAccent.shade400,fontWeight: FontWeight.bold),)),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text('Tittle',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(width: 2,color: Colors.purpleAccent.shade400)
                                                  ),
                                                  child: TextField(
                                                    controller: titleController,
                                                    decoration: InputDecoration(
                                                        hintText: 'Enter your title',
                                                        hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                                                        border: OutlineInputBorder(borderSide: BorderSide.none)
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Text('Description',style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  height: 130,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(width: 2,color: Colors.purpleAccent.shade400)
                                                  ),
                                                  child: TextField(
                                                    maxLines: 3,
                                                    controller: descController,
                                                    decoration: InputDecoration(
                                                        hintText: 'Enter your description',
                                                        hintStyle: TextStyle(fontSize: 12,color: Colors.black),
                                                        border: OutlineInputBorder(borderSide: BorderSide.none)
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                /// Button
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [


                                                    ElevatedButton(onPressed: (){
                                                     updateTaskInDB(sNo: allTasks[index][DbHelper.tableColumnSNo]);
                                                      Navigator.pop(context);
                                                    }, child: Text('Update',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent.shade400.withOpacity(0.5)),),

                                                    SizedBox(
                                                      width: 40,
                                                    ),

                                                    ElevatedButton(onPressed: (){
                                                      Navigator.pop(context);
                                                    }, child: Text('Cancel',style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),style: ElevatedButton.styleFrom(backgroundColor: Colors.purpleAccent.shade400.withOpacity(0.5)),),

                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                    },
                                    child: Icon(Icons.edit_sharp,size: 28,color: Colors.grey.shade600,)),
                                SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                    onTap: (){
                                      mainDb!.deleteTask(sNo: allTasks[index][DbHelper.tableColumnSNo]);
                                      getInitialTask();
                                    },
                                    child: Icon(Icons.delete_rounded,size: 28,color: Colors.grey.shade600,))
                              ],
                            ),
                          ),
                        ),
                      ),
                
                    );
                }),
              ): Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text("No Task Yet!!",style: TextStyle(fontSize: 15,color: Colors.purpleAccent.shade400,fontWeight: FontWeight.bold),),
                ),
              )
            )

          ],
        ),
      )
    );
  }
    /// Add Task
   void addTaskInDB() async{
    var mTitle = titleController.text.toString();
    var mDesc = descController.text.toString();



    bool isTrue = await mainDb!.addTask(title: mTitle, desc: mDesc);
    String msg = "Task add failed!!";

    if(isTrue){
      msg = "Task added Successfully";
      getInitialTask();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
   }

   /// Update task
    void updateTaskInDB({required int sNo}) async{
    var mTitle = titleController.text.toString();
    var mDesc = descController.text.toString();

    bool isTrue = await mainDb!.updateTask(title: mTitle, desc: mDesc, sNo: sNo );
    String msg = "Task Updated failed!!";

    if(isTrue){
      msg = "Task Update Successfully!!";
      getInitialTask();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}