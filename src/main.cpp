#include "frame.h"
#include <wx/wx.h>

class MyApp : public wxApp {
public:
    bool OnInit() override;
};

wxIMPLEMENT_APP(MyApp);

bool MyApp::OnInit()
{
    MyFrame* frame = new MyFrame();
    frame->Show(true);
    return true;
}
