import '../../../../models/user_model.dart';

class CustomerTableSource {
  static final List<UserModel> mockCustomers = List.generate(
    10,
        (i) => UserModel(
      id: "$i",
      username: "user$i",
      email: "user$i@gmail.com",
      firstName: "First$i",
      lastName: "Last$i",
      phoneNumber: "09000000${i}1",
      profilePicture: "https://via.placeholder.com/48?text=U$i",
    ),
  );
}