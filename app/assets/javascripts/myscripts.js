
var app = window.app = {};

app.Users = function() {
  this._input = $('#user-search-txt');
  this._initAutocomplete();
};

app.Users.prototype = {

  _initAutocomplete: function() {
    this._input
      .autocomplete({
        source: '/users/autocomplete.json',
        appendTo: '#user-search-results',
        select: $.proxy(this._select, this)
      })
      .autocomplete('instance')._renderItem = $.proxy(this._render, this);
  },

  _select: function(e, ui) {
    this._input.val(ui.item.value);
    return false;
  },

  _render: function(ul, item) {

    var markup = [
      '<span class="userResult">' + item.value + '</span>',
    ];
    return $('<li>')
      .append(markup.join(''))
      .appendTo(ul);
  }

};




/* -----------------------------------------------------*/
/*
var ready;
ready = (function() {
alert("blub");
  $('a[href="' + this.location.pathname + '"]').parent().addClass('active');
  $("#navbar-search-input").autocomplete({
    source: '/users/autocomplete.json',
    appendTo: '.results'
  });
});

$(document).ready(ready);
$(document).on('page:load', ready);


$(document).ready(function(){
    $("#help").click(function(){
        alert('blub');
    });
});
*/

