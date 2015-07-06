class PagesController < ApplicationController
  def home
    @qotd = Quote.order("created_at").last.text
  end

  def grid
  end

  def react
  end

  def about
    @colors = %w(red blue green)
    @color = @colors.sample
  end
end
