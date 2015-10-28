class WelcomeController < ApplicationController
  def index
    @article = Article.find_by(id: 77)
  end
end
