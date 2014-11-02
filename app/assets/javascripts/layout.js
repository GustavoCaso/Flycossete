$(document).ready(function(){
  $('ul.main-nav a.heading').on('click', function(e){
    e.preventDefault();
    link_clicked = $(this);
    if(link_clicked.hasClass('current')){
      $('ul.products').slideUp('slow');
      link_clicked.removeClass('current');
    }else {
      $('ul.products').slideDown('slow', function(){
        link_clicked.addClass('current');
      });
    }
  });


});
