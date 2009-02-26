# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def logged_in?
    !!current_user
  end
  
  def render_code(code)
    
    # Format it via CodeRay, and process the result specially for blogger
    formatted_code = CodeRay.scan(code, :ruby).div({
              :css => :class,
              :wrap => :page
            }
      )
    
    # Blogger has this quirk where it transforms newlines to <br />
    # tags. This is great, except when you don't want it, for instance
    # the HTML <tr><br /><td> is illegal. This code finds all of the
    # places where things like <tr> exist with a newline after them,
    # and removes the newline
    blogger_result = formatted_code.gsub(/(\s*\n\s*)(<|<\/)(table|tr|td)/i) { |x| x.gsub("\n"," ") }
    
    # CodeRay produces <tt> elements that have nothing but a newline in them.
    # Replacing these with simple \n (which blogger transforms to <br />)
    # also helps in making things line up nicely. Note the space after the
    # newline. That turns out to be important to get nice results in IE.
    #blogger_result.gsub!(/<tt>\s*\n\s*<\/tt>/i, "\n ")
    return blogger_result
  end

end
