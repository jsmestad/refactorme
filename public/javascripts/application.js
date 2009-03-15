
function openSlider(self, refactorHeight)
{
  if(self.attr("box_h") > refactorHeight) {
    refactorHeight = refactorHeight + "px";
  	var open_height = self.attr("box_h") + "px";
  	self.animate({"height": open_height}, { duration: "slow" });
  	self.unbind('click');
  	self.click(function() { closeSlider(jQuery(this), refactorHeight); });
  }
}

function closeSlider(self, refactorHeight)
{
	self.animate({ "height": refactorHeight }, { duration: "slow" });
	self.unbind('click');
	self.click(function() { openSlider(jQuery(this), refactorHeight); });
}


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
    self.parents('ul').next("div.hidden").slideToggle("slow"); 
    return false;
  });
  
  jQuery('a.send_to_gist').live('click', function() {
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
      
        self.closest('.action').addClass('voted').html("Voted");
      
      });
      return false;
    }
  });
  
  jQuery('.refactor .gist-data').each(function() { jQuery(this).attr("box_h", jQuery(this).height()); });
	jQuery(".refactor .gist-data").css("height", "125px");
	jQuery('.refactor .gist-data').click(function() { openSlider(jQuery(this), "125"); });
  
  jQuery('#snippet.code .gist-data:first').each(function() { jQuery(this).attr("box_h", jQuery(this).height()); });
  jQuery('#snippet.code .gist-data:first').css("height", "200px");
  jQuery('#snippet.code .gist-data:not(:first)').parent().remove();
  jQuery('#snippet.code .gist-data:first').click(function() { openSlider(jQuery(this), "200")});
});

jQuery(document).ajaxSend(function(event, request, settings) {
  if (settings.type == 'GET' || settings.type == 'get' || typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});


	