class PagesController < ApplicationController
  def home
    @qotd = Quote.order("created_at").last.text
  end

  def grid
  end

  def react
  end

  def about
  end

  def portfolio
  end
end
