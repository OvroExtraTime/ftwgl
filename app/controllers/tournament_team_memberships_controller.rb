class TournamentTeamMembershipsController < ApplicationController
  def create
    @member = TournamentTeamMembership.new
    @tt = TournamentTeam.find(params[:tournament_team])
    @member.tournament_team = @tt
    @member.tournament = @tt.tournament
    @user = User.find(params[:user])
    @member.user = @user

    respond_to do |f|
      if @member.save
        f.html {
          redirect_to :back,
          notice: 'Member was successfully added.'
        }
      else
        f.html {
          redirect_to :back,
          alert: 'Failed to add member. May already be on a tournament roster.'
        }
      end
    end
  end

  def update
    @member = TournamentTeamMembership.find(params[:id])
    @member.authorization_id = params[:tournament_team_membership][:authorization_id]
    respond_to do |f|
      if @member.save
        f.html {
          redirect_to :back,
          notice: 'Member was successfully updated.'
        }
      else
        f.html {
          redirect_to :back,
          alert: 'Failed to update member.'
        }
      end
    end
  end

  def destroy
    @member = TournamentTeamMembership.find(params[:id])
    @tt = @member.tournament_team

    respond_to do |f|
      if @member.destroy
        f.html {
          redirect_to :back,
          notice: 'Member was successfully deleted.'
        }
      else
        f.html {
          redirect_to :back,
          alert: 'Failed to delete member.'
        }
      end
    end
  end
end
