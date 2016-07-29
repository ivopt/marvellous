// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

(function($){
  function attachEvents(comics) {
    $(comics).find('.comic').each(function(o, comic){
      $(comic).find('.heart').on('click', function() {
        $(comic).toggleClass('favourite')
      });
    });
  }

  function ready(){
    $('.comics').each(function(i, comics){ attachEvents(comics); });
  }

  $(document).ready(ready);
  $(document).on('page:load', ready);
})(jQuery);

