$(document).ready(function () {
  var cards = Array.from(document.getElementsByClassName("card"));

  function switchCardsLayout(x) {
    if (x.matches) {
      cards.forEach((card) => {
        card.classList.remove("card-regular");
        card.classList.add("card-horizontal");
      });
    } else {
      cards.forEach((card) => {
        if (card.classList.contains("card-horizontal")) {
          card.classList.remove("card-horizontal");
        }
        card.classList.add("card-regular");
      });
    }
  }

  var x = window.matchMedia("(max-width: 575px)");
  switchCardsLayout(x);
  x.addListener(switchCardsLayout);
});