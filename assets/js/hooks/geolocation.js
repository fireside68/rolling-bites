export function getUserLocation() {
  console.log("Getting user location..."); // Log the call

  return new Promise((resolve, reject) => {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(
        position => {
          console.log("User location found:", position); // Log the found location
          resolve({
            latitude: position.coords.latitude,
            longitude: position.coords.longitude,
          });
        },
        error => {
          console.log("Error getting location:", error); // Log any errors
          reject(error);
        }
      );
    } else {
      console.error("Geolocation is not supported by this browser."); // Log if browser does not support geolocation
      reject(new Error("Geolocation is not supported by this browser."));
    }
  });
}
