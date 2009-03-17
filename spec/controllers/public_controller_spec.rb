require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PublicController do
  describe 'with an existing template' do
    before do
      get :show, :path => %w[ about ]
    end

    it 'should return successfully' do
      response.should be_success
    end

    # it 'should set the Last-Modified header' do
    #   response.headers['Last-Modified'].should_not be_nil
    # end

    it 'should render the matching template' do
      response.should render_template('public/about.html.haml')
    end
  end

  describe 'with an existing template directory' do
    before do
      get :show, :path => %w[ api ]
    end

    it 'should return successfully' do
      response.should be_success
    end

    # it 'should set the Last-Modified header' do
    #   response.headers['Last-Modified'].should_not be_nil
    # end

    it 'should render the index template in the directory' do
      response.should render_template('public/api/index.html.haml')
    end
  end

  describe 'with an If-Modified-Since less than the template modification time' do
    before do
      last_modified = Rails.root.join('app', 'views', 'public', 'about.html.haml').mtime.httpdate

      @request.env['HTTP_IF_MODIFIED_SINCE'] = last_modified

      get :show, :path => %w[ about ]
    end

    # it 'should return a 304 Not Modified Status' do
    #   response.status.to_i.should == 304
    # end
  end

  describe 'with an invalid path' do
    before do
      get :show, :path => %w[ invalid- ]
    end

    it 'should return a 400 Bad Request Status' do
      response.status.to_i.should == 400
    end

    it 'should render the exceptions/400 template' do
      response.should render_template('exceptions/400')
    end
  end

  describe 'with an unknown template' do
    before do
      get :show, :path => %w[ unknown ]
    end

    it 'should return a 404 Not Found Status' do
      response.status.to_i.should == 404
    end

    it 'should render the exceptions/400 template' do
      response.should render_template('exceptions/404')
    end
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
