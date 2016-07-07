$(document).ready(function () {
    $(".filter-box .select").change(function() {
        $(this).parents("form").submit();
    });
    
    $(".filter-box .keyword_search_button").click(function() {
        $(this).parents("form").submit();
    });
    
    $(".select").select2();
});
