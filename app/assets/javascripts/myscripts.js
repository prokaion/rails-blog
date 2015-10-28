
/* autocomplete User search */
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
        minLength: 2,
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
}; /* end autocomplete User search */


function toggle_glyph(id) {
    var e = document.getElementById(id);
    if(e.className == 'glyphicon glyphicon-plus-sign')         
      e.className = 'glyphicon glyphicon-minus-sign';
    else
      e.className = 'glyphicon glyphicon-plus-sign';
}



