RSpec.describe TeamController, type: :controller do
  describe "next_rec" do
    it "assigns @suggested_team" do
      get(:show, {'id' => "1"}, {'user_id' => 1})
      xhr :get, :next_rec
      expect(response).to render_template(partial: "_pane")
    end
  end

  describe "prev_rec" do
    it "assigns @suggested_team" do
      get(:show, {'id' => "1"}, {'user_id' => 1})
      xhr :get, :prev_rec
      expect(response).to render_template(partial: "_pane")
    end
  end
end
