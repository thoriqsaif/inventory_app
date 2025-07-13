// ignore: unused_field
enum NavigationRoutes {
  signin('/signin'),
  register('/register'),
  inventoryPage('/inventory'),
  detailInventory('/detailInventory'),
  addInventory('/addInventory');

  const NavigationRoutes(this.name);
  final String name;
}
