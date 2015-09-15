require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  # "New" way to check destroy action
  #describe "DELETE #destroy" do
    #let!(:participation) { create(:participation, user: user, project: project)}
    #before { delete :destroy, :project_id => project, :id => user }

    #it { expect(assigns(:participation)).to be_destroyed }
  #end
end
