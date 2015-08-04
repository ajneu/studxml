#include <iostream>
#include <string>
#include <fstream>

#include <xml/parser>
#include <xml/serializer>
#include <xml/value-traits>

using namespace std;
using namespace xml;

using std::ifstream;

enum gender{male, female};
std::istream &operator>>(std::istream &is, gender &g)
{
  std::string s;
  if (is >> s) {
    if (s == "male")
      g = male;
    else if (s == "female")
      g = female;
  }
  return is;
}

std::ostream &operator<<(std::ostream &os, const gender &g)
{
  return os << ((g == male) ? "male" : "female");
}


int main()
{
  std::string filename{"a.xml"};

  {
    ofstream ofs(filename);
    ofs <<
R"(<person>
  <name>John Doe</name>
  <age>23</age>
  <gender>male</gender>
</person>
)";
  }
  
  ifstream ifs (filename);
  parser p (ifs, filename);

  p.next_expect (parser::start_element,
                 "person",
                 content::complex);
  string n = p.element ("name");
  short  a = p.element<short> ("age");
  gender g = p.element<gender> ("gender");
  p.next_expect (parser::end_element);

  std::cout << "Name  : " << n << "\n"
               "Age   : " << a << "\n"
               "Gender: " << g << std::endl;
  return 0;
}
