$(window).load(function(){
  if($(".alert-danger").length > 0){
    $('#loginModal').modal('show');
  }
});

$(document).ready(function(){
  listenersOn();
  $('.login-form').removeAttr('novalidate')
  if ($('.alert').text() == "Invalid sign up. Please make sure your passwords match."){
    showSignUp()
  }else if ($('.alert').text() == "We have no record of that e-mail address."){
    showForgotPassword()
  }
});

$(".alert-success").alert();
window.setTimeout(function() { $(".alert-success").alert('close'); }, 5000);

function listenersOn(){
  signUpClick();
  logInClick();
  forgotPasswordClick();
}

function hideAlert(){
  $('.alert').text("")
}

function signUpClick(){
  $(".sign-up-link").on('click', function(e){
    e.preventDefault();
    showSignUp()

  });
}
function showSignUp(){
  $('#login-partial').hide();
  $('#forgot-password').hide();
  $('#signup-partial').show();
}

function logInClick(){
  $(".log-in-link").on('click', function(e){
    e.preventDefault();
    $('.login-form').removeAttr('novalidate')
    $('#signup-partial').hide();
    $('#forgot-password').hide();
    $('#login-partial').show();
  });
}

function forgotPasswordClick(){
  $(".forgot-password-link").on('click', function(e){
    e.preventDefault();
    $('.login-form').removeAttr('novalidate')
    showForgotPassword()
  });
}

function showForgotPassword(){
  $('#signup-partial').hide();
  $('#login-partial').hide();
  $('#forgot-password').show();
}
