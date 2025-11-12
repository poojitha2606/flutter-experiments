void main() { 
String name = 'John'; 
int age = 20; 
print('Name: $name, Age: $age'); 
if (age >= 18) { 
print('$name is an adult.'); 
} else { 
print('$name is a minor.'); 
} 
for (int i = 1; i <= 3; i++) { 
print('Count: $i'); 
} 
greet(name); 
} 
void greet(String name) { 
print('Hello, $name!'); 
}