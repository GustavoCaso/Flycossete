$(document).ready(function(){
  $('ul.main-nav a.heading').on('click', function(e){
    e.preventDefault();
    $(this).addClass('current');
    if($(this).parent().hasClass('current')){
      $(this).siblings('ul').slideUp('slow', function(){
        $(this).parent().removeClass('current');
      });
    }else {
      $('.ul.main-nav li.current ul').slideUp('slow', function(){
        $(this).parent().removeClass('current');
      });

      $(this).siblings('ul').slideToggle('slow', function(){
        $(this).parent().toggleClass('current');
      });
    }
  });


});