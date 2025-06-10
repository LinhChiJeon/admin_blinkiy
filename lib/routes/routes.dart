class Routes {
  static const login = '/login';
  static const forgetPassword = '/forget-password';
  static const resetPassword = '/reset-password';
  static const dashboard = '/dashboard';

  // Categories
  static const categories = '/categories';
  static const createCategory = '/categories/create';
  static const editCategory = '/categories/edit'; // Có thể thêm tham số sau này
  static const customers = '/customers'; // Có thể thêm tham số sau này

  static const orders = '/orders'; // Có thể thêm tham số sau này
  static const orderDetail = '/order-detail'; // Có thể thêm tham số sau này
  static List sidebarMenuItems = [
    // Thêm các màn bạn muốn hiển thị trong sidebar
    {
      'label': 'Categories',
      'icon': 'category', // hoặc dùng Icons.category nếu bạn gán ngoài Widget
      'route': categories,
    },
    // Thêm các item khác nếu có (dashboard, products,...)
  ];
}

