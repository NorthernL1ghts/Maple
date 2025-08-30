#pragma once

#include "Maple/Core.h"
#include "Maple/Events/Event.h"
#include "Maple/Window.h"
#include "Maple/LayerStack.h"
#include "Maple/Events/Event.h"
#include "Maple/Events/ApplicationEvent.h"

namespace Maple {

	class MAPLE_API Application
	{
	public:
		Application();
		virtual ~Application();

		void Run();
		void OnEvent(Event& e);
		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);
	private:
		bool OnWindowClose(WindowCloseEvent& e);
		bool m_Running = true;
		std::unique_ptr<Window> m_Window;
		LayerStack m_LayerStack;
	};

	// To be defined in CLIENT
	Application* CreateApplication();

}