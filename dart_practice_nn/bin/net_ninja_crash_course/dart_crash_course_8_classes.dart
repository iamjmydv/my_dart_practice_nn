//-----------------------------------
//  C L A S S E S 
//-----------------------------------

// 
void main() {

    var noodle = MenuItem('veg noodles', 9.99);
    var pizza = MenuItem('volcano pizza', 12.99);

    print(noodle.format());
    print(pizza.format());
}

class MenuItem {
    String title = 'pizza';
    double price = 9.99;

    MenuItem(this.title, this.price);

    String format() {
        return "$title --> $price";
    }
}

//------------------------------------------------------------------------------
// Creating method in class that returns the value of the property of the constructor.
// void main() {

//     var noodle = MenuItem('veg noodles', 9.99);
//     var pizza = MenuItem('volcano pizza', 12.99);

//     print(noodle.format());
//     print(pizza.format());
// }

// class MenuItem {
//     String title = 'pizza';
//     double price = 9.99;

//     MenuItem(this.title, this.price);

//     String format() {
//         return "$title --> $price";
//     }
// }

//------------------------------------------------------------------------------
// //Basic creation of an object of an class with assigning property for reusable class
// void main() {

//     var noodle = MenuItem('veg noodles', 9.99);
//     var pizza = MenuItem('volcano pizza', 12.99);

//     print(noodle.title);
//     print(noodle.price);
//     print(pizza.title);
//     print(pizza.price);
// }

// class MenuItem {
//     String title = 'pizza';
//     double price = 9.99;

//     MenuItem(this.title, this.price);
// }

//------------------------------------------------------------------------------
// Basic creation of classes
// void main() {

//     var noodle = MenuItem();
//     var pizza = MenuItem();

//     print('PIZZA ${noodle.title}');
//     print('NOODLE ${noodle.title}');
  
// }

// class MenuItem {
//     String title = 'pizza';
//     double price = 9.99;
// }