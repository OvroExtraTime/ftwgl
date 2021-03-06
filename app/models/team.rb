class Team < ActiveRecord::Base
  attr_accessor :join_password
  attr_accessible :name, :tag, :join_password, :gravatar_email, :primary_contact, :secondary_contact,
  :website, :irc_channel, :voip, :youtube_channel, :twitch_channel, :featured_video, :description

  before_save :encrypt_join_password

  validates_presence_of :name, :tag
  validates_length_of :name, :maximum => 50, :message => "Team name is too long"
  validates_length_of :tag, :maximum => 8, :message => "Maximum tag length is 8"

  has_many :memberships, :autosave => true, dependent: :destroy
  has_many :users, through: :memberships
  has_many :tournament_teams, dependent: :destroy
  has_many :tournaments, through: :tournament_teams
  has_many :tournament_team_memberships, through: :tournament_teams, dependent: :destroy

  def encrypt_join_password
    if join_password.present?
      self.join_password_salt = BCrypt::Engine.generate_salt
      self.join_password_hash = BCrypt::Engine.hash_secret(join_password, join_password_salt)
    end
  end

  def self.authenticate_join(team, password)
    team = Team.find(team.id)

    if team && (team.join_password_salt.empty? && team.join_password_hash.empty?)
      return true
    end

    if team && team.join_password_hash == BCrypt::Engine.hash_secret(password, team.join_password_salt)
      return true
    else
      return false
    end
  end

  def owners
    owners = memberships.where("role = 'owner'")
    owners.map { |owner| owner.user }
  end

  def captains
    captains = memberships.where("role = 'captain'")
    captains.map { |captain| captain.user }
  end

  def actives
    actives = memberships.where("active = 'true'")
    actives.map { |active| active.user }
  end

  def members
    actives = memberships.where("active = 'true'")
    actives.map { |active| active.user }
  end

  def applications
    applications = memberships.where("active = 'false'")
    applications.map { |application| application.user }
  end

  def in_tournament?(tournament)
    if self.tournaments.where(id: tournament.id) != []
      return true
    else
      return false
    end
  end

  def save_with_owner(user)
    Team.transaction do
      save and Membership.create(:team => self, :user => user, :role => 'owner', :active => true)
    end
  end

  def team_info
    @team_info = Hash.new

    if self.primary_contact
      @team_info["primary contact"] = self.primary_contact
    end

    if self.secondary_contact
      @team_info["secondary contact"] = self.secondary_contact
    end

    if self.website
      @team_info["website"] = self.website
    end

    if self.irc_channel
      @team_info["irc channel"] = self.irc_channel
    end

    if self.voip
      @team_info["voip info"] = self.voip
    end

    if self.youtube_channel
      @team_info["youtube channel"] = self.youtube_channel
    end

    if self.twitch_channel
      @team_info["twitch channel"] = self.twitch_channel
    end

    if self.description
      @team_info["description"] = self.description
    end

    @team_info
  end

end


