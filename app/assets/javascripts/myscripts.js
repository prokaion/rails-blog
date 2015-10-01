$(document).ready(function(){
$( "#search" ).autocomplete({
alert("bla!");
    source:$('#search').data('source'),
    html: true,
    appendTo: "#search_results",
    select: function( event, ui ) {
        window.location=ui.item.value;
        return false;
    },
      focus: function( event, ui ) { },
      open: function( event, ui ) { }
}).data( "autocomplete" )._renderMenu = function( ul, items ) {
  $.ui.autocomplete.prototype._renderMenu.apply( this, [ul, items] );
  ul.append( '<li><a href="/search/'+ this.term + '">Search: '+ this.term + '</a></li>' );  
};
});
/*
$(document).ready(function(){
  $('#search').bind('keydown', function(event, data){
    
    alert("hello");
  });
});
*/
$(document).ready(function(){
    $("#help").click(function(){
        alert('blub');
    });
});

