$(document).ready(function () {
  var replyBtns = Array.from(document.querySelectorAll(".reply-btn"));
  var cancelBtns = Array.from(document.querySelectorAll(".cancel-btn"));

  replyBtns.forEach((btn) => btn.addEventListener("click", displayReplyForm));
  cancelBtns.forEach((btn) => btn.addEventListener("click", hideReplyForm));

  function displayReplyForm(e) {
    var formId = e.target.id
    var replyForm = document.getElementById(`reply-form-${formId}`)
    replyForm.style.display = "block";
  }
  
  function hideReplyForm(e) {
    var formId = e.target.id
    var replyForm = document.getElementById(`reply-form-${formId}`)
    replyForm.style.display = "none";
  }
});

