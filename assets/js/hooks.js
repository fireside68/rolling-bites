import IndexMap from "./hooks/index-map";
import Map from "./hooks/map";
import { getUserLocation } from "./hooks/geolocation"


let Hooks = {
  IndexMap: IndexMap,
  Map: Map
};

Hooks.GetLocation = {
  mounted() {
    getUserLocation().then(location => {
      this.pushEvent("got_location", location);
    });
  }
}

export default Hooks;
