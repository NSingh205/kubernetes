// When the button is clicked, call our own backend through the relative URL /api/health.
// "Relative" means: same website, so no server name is hard-coded anywhere.
const button = document.getElementById("check");
const result = document.getElementById("result");

button.addEventListener("click", async () => {
  result.textContent = "Checking...";
  try {
    const response = await fetch("/api/health");
    const data = await response.json();
    result.textContent = JSON.stringify(data, null, 2);
  } catch (error) {
    result.textContent = "Could not reach the backend: " + error.message;
  }
});
