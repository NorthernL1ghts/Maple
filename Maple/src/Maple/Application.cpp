#include "Application.h"

#include "Maple/Events/ApplicationEvent.h"
#include "Maple/Log.h"

namespace Maple {

	Application::Application()
	{
	}

	Application::~Application()
	{
	}

	void Application::Run()
	{
		WindowResizeEvent e(1280, 720);
		if (e.IsInCategory(EventCategoryApplication))
		{
			MP_TRACE(e);
		}
		if (e.IsInCategory(EventCategoryInput))
		{
			MP_TRACE(e);
		}

		while (m_Running);
	}
}