$(function() {
  $(document).on("click", "#add_tourny_team .pagination a", function() {
    $.getScript(this.href);
    return false;
  });
  $('#add_tourny_team #team_search').submit(function() {
    $.get(this.action, $(this).serialize(), null, "script");
    return false;
  });
});
