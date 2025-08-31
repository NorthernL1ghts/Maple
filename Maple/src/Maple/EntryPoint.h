#pragma once

#ifdef MP_PLATFORM_WINDOWS

extern Maple::Application* Maple::CreateApplication();

int main(int argc, char** argv)
{
	auto app = Maple::CreateApplication();
	app->Run();
	delete app;
}

#endif