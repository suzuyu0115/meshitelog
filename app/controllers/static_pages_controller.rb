class StaticPagesController < ApplicationController
  def top
    if current_user
      render 'posts/index'
    else
      render 'top'
    end
  end
end
