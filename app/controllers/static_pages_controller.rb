class StaticPagesController < ApplicationController
  def top
    if current_user
      redirect_to posts_path
    else
      render 'top'
    end
  end
end
