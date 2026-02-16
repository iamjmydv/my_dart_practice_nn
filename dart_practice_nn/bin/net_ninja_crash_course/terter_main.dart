void main() {
  Map<int, String> planets = {
    1 : "Mercury",
    2 : "Venus",
    3 : "Earth",
    4 : "Mars",
    5 : "Jupiter"
  };

  planets.forEach((key,value) {
    print('The key is $key and the value is $value');
  });
}