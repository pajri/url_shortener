document.addEventListener("DOMContentLoaded", () => {
    const btn = document.getElementById("copy-btn");
    const urlText = document.getElementById("short-url");

    if (btn) {
        btn.addEventListener("click", () => {
            navigator.clipboard.writeText(urlText.textContent.trim());
            btn.textContent = "Copied!";
            setTimeout(() => btn.textContent = "Copy", 1500);
        });
    }
});