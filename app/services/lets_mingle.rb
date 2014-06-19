class LetsMingle
	
	attr_accessor :email, :password, :project, :url

  def initialize(email, password, project=nil)
    @email = email
    @password = User.password(password)
    @project = project
    @url = "https://careerbuilder.mingle.thoughtworks.com/"
  end

  def login
  	Mingle4r::MingleClient.new(url,
      email, password)    
  end

  def project_login
  	Mingle4r::MingleClient.new(url,
      email, password, project)  
  end

  def get_cards
    project_login.cards
  end
  
  def get_projects
    login.projects.collect{|prj| [prj.name, prj.identifier]}
  end 

  def get_users
  end

end
