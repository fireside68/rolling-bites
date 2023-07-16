import Map from "./hooks/map";
import { getUserLocation } from "./hooks/geolocation"


let Hooks = {
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
