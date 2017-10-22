// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

(function($){
  function toggleFavourite(comicId) {
    $.ajax({
      url: '/comics/' + comicId + '/toggle_favourite',
      type: 'PUT'
    });
  }

  function attachEvents(comics) {
    $(comics).find('.comic').each(function(o, comic){
      $(comic).find('.heart').on('click', function() {
        $(comic).toggleClass('favourite');
        var comicId = $(comic).prop('id').replace("comic_", "");
        toggleFavourite(comicId);
      });
    });
  }

  function ready(){
    $('.comics').each(function(i, comics){ attachEvents(comics); });
  }

  $(document).ready(ready);
  $(document).on('turbolinks:load', ready);
})(jQuery);

