$(document).ready(function(){
  $(".tournament_bracket_type").hide();
  $(".tournament_elimination_type").hide();
  $(".tournament_bracket_size").hide();
  $("#tournament_tournament_type").change(function(){
    if($("#tournament_tournament_type").val() == "Bracket"){
      $(".tournament_bracket_type").fadeIn('fast');
      $(".tournament_elimination_type").fadeIn('fast');
      $(".tournament_bracket_size").fadeIn('fast');
    } else {
      $(".tournament_bracket_type").fadeOut('fast');
      $(".tournament_elimination_type").fadeOut('fast');
      $(".tournament_bracket_size").fadeOut('fast');
    };
  });
});
