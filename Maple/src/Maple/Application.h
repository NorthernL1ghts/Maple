#pragma once

#include "Core.h"

namespace Maple {

	class MAPLE_API Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();
    private:
        bool m_Running = true;
	};

	// To be defined in CLIENT
	Application* CreateApplication();
}