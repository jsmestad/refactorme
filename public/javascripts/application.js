
jQuery(document).ready(function() {
  
  jQuery('a.delete').live('click', function() {
    var answer = confirm('Are you sure?');
    var self = jQuery(this);
    if (answer == true) {
      $.post(self.attr('href') + ".js", { "_method": "delete" }, function(data) {
        self.parents('tr').remove();
        jQuery('#content').after('<div class=\"success\">' + data + '</div>');
        });
    }
    return false;
  });
  
  jQuery('a.approve').live('click', function() {
    var self = jQuery(this);
    $.post(self.attr('href') + ".js", {}, function(data) {
      jQuery('#content').after('<div class=\"notice\">' + data + '</div>');
    });
    
    return false;
  });
  
});

jQuery(document).ajaxSend(function(event, request, settings) {
  if (settings.type == 'GET' || settings.type == 'get' || typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});