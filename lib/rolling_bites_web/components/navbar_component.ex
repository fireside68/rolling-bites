defmodule RollingBitesWeb.NavbarComponent do
  use RollingBitesWeb, :live_component

  def render(assigns) do
    ~H"""
    <nav class="flex items-center justify-between flex-wrap p-6">
      <div class="block lg:hidden">
        <button class="flex items-center px-3 py-2 border rounded text-teal-200 border-teal-400 hover:text-orange-700">
          <svg class="fill-current h-3 w-3" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><title>Menu</title><path d="M0 3h20v2H0V3zm0 6h20v2H0V9zm0 6h20v2H0v-2z"/></svg>
        </button>
      </div>
      <div class="w-full block flex-grow lg:flex lg:items-center lg:w-auto">
        <div class="text-sm lg:flex-grow">
          <a href="/" class="block mt-4 lg:inline-block lg:mt-0 text-teal-950 hover:text-orange-700 mr-4">
            Home
          </a>
          <a href="/#trucks-container" class="block mt-4 lg:inline-block lg:mt-0 text-teal-950 hover:text-orange-700 mr-4">
            Trucks
          </a>
          <a href="#responsive-header" class="block mt-4 lg:inline-block lg:mt-0 text-teal-950 hover:text-orange-700">
            Blog
          </a>
        </div>
      </div>
    </nav>
    """
  end
end
