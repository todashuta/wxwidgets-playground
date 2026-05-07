#include <iostream>
#include <wx/utils.h>

int main(int argc, char* argv[]) {
	std::cout << "Hello! " << wxGetLibraryVersionInfo().GetVersionString() << std::endl;
	return 0;
}
