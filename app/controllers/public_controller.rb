class PublicController < ApplicationController
  class InvalidPath < StandardError; end
  class UnknownTemplate < StandardError; end

  PATH_SEGMENT = /\A[a-z](?:-?[a-z]+)*\z/.freeze

  rescue_from InvalidPath,     :with => :bad_request
  rescue_from UnknownTemplate, :with => :not_found

  def show
    # validate the path
    unless (parts = params[:path].grep(PATH_SEGMENT)) == params[:path]
      raise InvalidPath, "Path #{params[:path].join('/')} is invalid"
    end

    base = Rails.root.join('app', 'views')
    path = base.join(controller_name, *parts)

    # use the index template if the path is a directory
    template = if path.directory?
      path.join('index.html.haml')
    else
      Pathname("#{path}.html.haml")
    end

    # check to make sure the template exists
    unless template.file?
      raise UnknownTemplate, "Template #{template} is unknown"
    end

    # perform a conditional GET if the template is not modified
    #if stale?(:last_modified => template.mtime)
      render :template => template.relative_path_from(base).to_s
    #end
  end
end

__END__

Copyright (c) 2009 Dan Kubb

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
