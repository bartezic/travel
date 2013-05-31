ActiveAdmin.register AdminUser do     
  menu :priority => 20, :label => proc{ I18n.t('active_admin.menu.users') }
  
  member_action :fb_auth do
    user = AdminUser.find(params[:id])

    fb_auth = FbGraph::Auth.new(256487544493099, 'c6e6495f50b6afc7658702174f3fb69f')
    client = fb_auth.client
    client.redirect_uri = "#{request.protocol + request.host_with_port}/admin/admin_users/#{params[:id]}/fb_callback"

    # redirect user to facebook
    redirect_to client.authorization_uri(
      :scope => [:email, :read_stream, :offline_access, :manage_pages]
    )
  end

  member_action :vk_auth do
  end

  member_action :fb_callback do
    user = AdminUser.find(params[:id])

    fb_auth = FbGraph::Auth.new(256487544493099, 'c6e6495f50b6afc7658702174f3fb69f')
    client = fb_auth.client
    client.redirect_uri = "#{request.protocol + request.host_with_port}/admin/admin_users/#{params[:id]}/fb_callback"
    client.authorization_code = params[:code]
    token = client.access_token!(:client_auth_body).access_token

    if user.update_attributes(fb_token: token)
      redirect_to :back, {:notice => "Connected!"}
    else
      redirect_to :back, {:notice => "Fake!"}
    end
  end

  index do
    selectable_column
    id_column                            
    column :email                     
    column :current_sign_in_at        
    column :last_sign_in_at           
    column :sign_in_count             
    default_actions
    column :clone do |user|
      span { link_to "FB", { :action => 'fb_auth', :id => user } }
      span { link_to "VK", { :action => 'vk_auth', :id => user } }
    end               
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end                                 
end                                   
