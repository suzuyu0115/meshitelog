class StaticPagesController < ApplicationController
  def top
    if current_user
      redirect_to posts_path
    else
      render 'top'
    end
  end

  def terms; end

  def privacy; end
end
