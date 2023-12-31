// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import topbar from "../vendor/topbar"
import Hooks from "./hooks"
import { getUserLocation } from "./hooks/geolocation"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks,
  mounts: {
    getLocation: getUserLocation
  }
})

document.addEventListener("DOMContentLoaded", () => {
  const filterForm = document.querySelector('[phx-target="filter-form"]');

  filterForm.addEventListener("keyup", (event) => {
    event.preventDefault();
    const query = event.target.value.trim();
    filterTrucks(query);
  });

  function filterTrucks(query) {
    const truckCards = document.querySelectorAll(".truck-card");
    truckCards.forEach((card) => {
      const truckName = card.querySelector(".truck-name").innerText.toLowerCase();
      if (truckName.includes(query.toLowerCase())) {
        card.style.display = "block";
      } else {
        card.style.display = "none";
      }
    });
  }
});

// Select menu button
const menuButton = document.querySelector('.block.lg\\:hidden button');

// Select menu
const menu = document.querySelector('#menu');

// Define a function to check screen size
function checkScreenSize() {
  const screenWidth = window.innerWidth;

  // Assume 1024px as the breakpoint for large screens, adjust as needed
  if (screenWidth <= 1024) {
    menu.classList.remove('hidden');
  } else {
    menu.classList.add('hidden');
  }
}

// Run the function when the window is resized
window.addEventListener('resize', checkScreenSize);

// Run the function when the document is loaded
document.addEventListener('DOMContentLoaded', checkScreenSize);

// Add event listener for click, but only toggle menu if it's not a large screen
menuButton.addEventListener('click', function() {
  if (window.innerWidth <= 1024) {
    menu.classList.toggle('hidden');
  }
});



// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" })
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket
