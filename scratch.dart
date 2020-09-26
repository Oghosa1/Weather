import 'dart:io';

void main() {
  performTask();
}

void performTask() async {
  task1();
  String task2Result = await task2();
  task3(task2Result);
}

void task1() {
  String result = 'task 1 data';
  print(result);
}

Future<String> task2() async {
  Duration threeSconds = Duration(seconds: 3);
  String result;
  // sleep(threeSconds);
  Future.delayed(threeSconds, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String task2Data) {
  String result = 'task 3 data';
  print('task 3 complete $task2Data');
}
