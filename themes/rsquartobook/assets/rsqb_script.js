document.addEventListener("DOMContentLoaded", function () {
    function adjustTopMargin() {
        const content = document.querySelector("#quarto-content");
        if (content) {
            if (window.innerWidth < 991) {
                content.style.marginTop = "calc(2rem + 27px + 4px)";
            } else {
                content.style.marginTop = "";
            }
        }
    }

    // Adjust margin on page load
    adjustTopMargin();

    // Adjust margin on window resize
    window.addEventListener("resize", adjustTopMargin);
});
