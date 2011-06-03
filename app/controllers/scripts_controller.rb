module ScriptGenerator
  class NoCoffee < Exception
  end

  def self.build_script(id)
    load_js_string path(id)
  end

  def self.last_modified(id)
    File.mtime(path(id))
  end

  def self.path id
    id = id.gsub /[^\w-]/, ''
    path = "#{Rails.root}/app/assets/javascripts/#{id}.js.coffee"
    raise NoCoffee.new unless File.exist? path
    path
  end

  private

  def self.load_js_string path
    if path =~ /\.coffee\Z/
      CoffeeScript.compile File.read(path), :bare => true
    else
      File.read(path)
    end
  end
end



class ScriptsController < ApplicationController
  def show
    headers['Cache-Control'] = 'public, max-age=2592000' # cache for a month
    headers['Last-Modified'] = ScriptGenerator::last_modified(params[:id]).to_s(:long)

    render :js => ScriptGenerator::build_script(params[:id])

  rescue ScriptGenerator::NoCoffee
    render :nothing => true, :status => :not_found
  end
end
