main() {
  List<int> nums = [0, 1, 2, 3, 4, 5, 6, 7,0];

  List<int> nums1 = nums.where((e) => e > 10).toList();
  print(nums1);

  int num2 = nums.singleWhere((e) => e == 0);
  print(num2);
}
