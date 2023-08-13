RailsAdmin.config do |config|
  config.asset_source = :sprockets

  ### Popular gems integration

  config.authenticate_with do
    user_id = session[:user_id]
    user = User.find_by(id: user_id) if user_id
    unless user && user.admin?
      flash[:alert] = "権限がありません"
      redirect_to main_app.root_path
    end
  end

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  # Userモデルの設定
  config.model 'User' do
    list do
      scopes [:with_associations]
    end
  end

  # Postモデルの設定
  config.model 'Post' do
    list do
      scopes [:with_associations]
    end
  end
end
