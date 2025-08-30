#pragma once

#include "Maple/Core.h"
#include "Maple/Events/Event.h"
#include "Maple/Window.h"
#include "Maple/Events/ApplicationEvent.h"

namespace Maple {

	class MAPLE_API Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();
		void OnEvent(Event& e);
	private:
		bool OnWindowClose(WindowCloseEvent& e);
		bool m_Running = true;
		std::unique_ptr<Window> m_Window;
	};

	// To be defined in CLIENT
	Application* CreateApplication();

}