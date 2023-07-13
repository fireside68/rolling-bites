export function getUserLocation() {
  if ("geolocation" in navigator) {
    return new Promise((resolve, reject) => {
      navigator.geolocation.getCurrentPosition(
        position => resolve({ latitude: position.coords.latitude, longitude: position.coords.longitude }),
        error => reject(error)
      );
    });
  } else {
    return Promise.reject(new Error("Geolocation is not supported by this browser."));
  }
}
