
jQuery(document).ready(function() {

  var displayMessage = function(className, msg) {
    jQuery('#content').after('<div class=\"' + className + '\">' + msg + '</div>');
  }
  
  jQuery('a.delete').live('click', function() {
    var answer = confirm('Are you sure?');
    var self = jQuery(this);
    if (answer == true) {
      $.post(self.attr('href') + ".js", { "_method": "delete" }, function(data) {
        self.parents('tr').remove();
        displayMessage('success', data);
        });
    }
    return false;
  });
  
  jQuery('a.approve').live('click', function() {
    var self = jQuery(this);
    $.post(self.attr('href') + ".js", { "approved" : "true" }, function(data) {
      displayMessage('notice', data);
    });
    
    return false;
  });
  
  jQuery('a.fork').live('click', function() {
    var self = jQuery(this);
    self.parent().next("div.hidden").slideToggle("slow"); 
    return false;
  });
  
  jQuery('a.gist').live('click', function() {
    var self = jQuery(this);
    $.get(self.attr('href') + ".js", function(data) {
      self.replaceWith("<a href=\"" + data + "\">View Gist</a>");
    });
    return false;
  });
  
  jQuery('a.vote').click(function() {
    var self = jQuery(this);
    if (!self.hasClass("reg")) {
      value = self.hasClass("vote_up") ? 1 : -1;
      $.post(self.attr('href'), { "vote[score]": value }, function(data) {
        if (self.hasClass("vote_up")) {
          var count = self.parents('.votes').find('.positive_vote');
          var score = parseInt(self.parents('.votes').find('.positive_vote').html());
          score = score + value;
          self.parents('.votes').find('.positive_vote').html("+" + score);
        }else{  
          var count = self.parents('.votes').find('.negative_vote');
          var score = parseInt(self.parents('.votes').find('.negative_vote').html());
          score = score + value;
          self.parents('.votes').find('.negative_vote').html(score);
        }
      
        self.parent().replaceWith("Voted");
      
      });
      return false;
    }
  });
  
});

jQuery(document).ajaxSend(function(event, request, settings) {
  if (settings.type == 'GET' || settings.type == 'get' || typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});
