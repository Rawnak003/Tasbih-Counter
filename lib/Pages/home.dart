import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _goalController = TextEditingController();
  var _steps = 0;
  String _goal = '0';
  double _progress = 0.0;
  _updateStep(){
    setState(() {
      _steps+=1;
    });
  }
  _clean(){
    setState(() {
      _steps = 0;
      _progress = 0.0;
      _goal = '0';
    });
  }
  _updateProgress(){
    setState(() {
      if(_steps <= double.parse(_goal)){
        _progress = _steps / double.parse(_goal);
      }else{
        _clean();
        mySnackBar("Successfully reached the goal! Set new.", context);
      }
    });
  }
  _setGoal(){
    if(_goalController.text.isNotEmpty){
      setState(() {
        _goal = _goalController.text;
        _goalController.clear();
      });
    }
  }
  mySnackBar(message, context){
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasbih Counter',
        style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
        centerTitle: true,
        elevation: 18.0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children:[
              Card(
                margin: const EdgeInsets.all(16.0),
                color: Colors.grey.shade100,
                elevation: 5.0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _goalController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.deepPurpleAccent),
                                borderRadius: BorderRadius.circular(8.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black,width: 2),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          labelText: 'Goal',
                          labelStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: (){
                                  _setGoal();
                                  mySnackBar('Goal Set Successfully.', context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepPurpleAccent.shade400,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                                ),
                                child: const Text('Set Goal',style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),)
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ),
              const SizedBox(
                height: 8,
              ),
              Card(
                margin: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                child: Column(
                  children: [
                    LinearProgressIndicator(
                      value: _progress,
                      minHeight: 15.0,
                      borderRadius: BorderRadius.circular(8),
                      backgroundColor: Colors.grey.shade200,
                      valueColor: const AlwaysStoppedAnimation(
                          Colors.deepPurpleAccent
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${_goal.toString()}/${_steps.toString()}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),)
                        ]
                      ),
                    )
                  ],
                )
              ),
              const SizedBox(
                height: 150,
              ),
              Text(_steps.toString(),
                style: TextStyle(
                  color: Colors.deepPurpleAccent.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 60,
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(onPressed: () {
                    _clean();
                    mySnackBar("Cleared all!!!", context);
                  },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(80, 50),
                      backgroundColor: Colors.deepPurpleAccent.shade400,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                    ), child: const Icon(Icons.delete,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(onPressed: () {
                    _updateStep();
                    _updateProgress();
                  },
                    style: ElevatedButton.styleFrom(
                      alignment: Alignment.center,
                      fixedSize: const Size(80, 50),
                      backgroundColor: Colors.deepPurpleAccent.shade400,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0),),
                    ), child: const Icon(Icons.add,
                        size: 30,
                        color: Colors.white,
                    ),
                  ),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }
}