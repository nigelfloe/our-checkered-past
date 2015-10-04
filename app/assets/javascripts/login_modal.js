$(window).load(function(){
  if($(".alert-danger").length > 0){
    $('#loginModal').modal('show');
  }
});

$(document).ready(function(){
  listenersOn();
});

$(".alert-success").alert();
window.setTimeout(function() { $(".alert-success").alert('close'); }, 5000);

function listenersOn(){
  signUpClick();
  logInClick();
  forgotPasswordClick();
}

function signUpClick(){
  $(".sign-up-link").on('click', function(e){
    e.preventDefault();
    $('#login-partial').hide();
    $('#forgot-password').hide();
    $('#signup-partial').show();
  });
}

function logInClick(){
  $(".log-in-link").on('click', function(e){
    e.preventDefault();
    $('#signup-partial').hide();
    $('#forgot-password').hide();
    $('#login-partial').show();
  });
}

function forgotPasswordClick(){
  $(".forgot-password-link").on('click', function(e){
    e.preventDefault();
    $('#signup-partial').hide();
    $('#login-partial').hide();
    $('#forgot-password').show();
  });
}
