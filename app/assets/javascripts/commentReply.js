$(document).ready(function () {
  const replyBtns = Array.from(document.querySelectorAll(".reply-btn"));

  replyBtns.forEach(btn => btn.addEventListener('click', displayReplyForm));

  function displayReplyForm(e){
    e.target.style.display="block";
  }
});





