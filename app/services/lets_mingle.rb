class LetsMingle
	
	attr_accessor :email, :password, :project, :url

  def initialize(email, password, project=nil)
    @email = email
    @password = password
    @project = project
    @url = "https://careerbuilder.mingle.thoughtworks.com/"
  end

  def update_user
    user = project_login.users.find{|u| u.user.email.downcase == email.downcase}
    User.where(:email_id=>email).first.update_attributes(:is_admin => user.admin)
  end

  def login
  	Mingle4r::MingleClient.new(url,
      email, password)    
  end

  def project_login
  	Mingle4r::MingleClient.new(url,
      email, password, project)  
  end

  def project_users
    project_login.users.find{|u| u.admin == true && u.user.email == email}
  end

  def get_cards
  	project_login.execute_mql('SELECT number, name, description,type WHERE "Delivery Status" = Ready AND Estimate is null') 
  end
  
  def get_projects
    projects = login.projects.collect{|prj| [prj.name, prj.identifier]}
    projects.each do |p|
      Project.where(mingle_name: p.last).first_or_create
    end
    projects
  end 

  def get_users
    project_login.users.collect{|u| u.user.email}
  end

end
