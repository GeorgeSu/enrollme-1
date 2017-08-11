RSpec.describe TeamController, type: :controller do
  describe "next_rec" do
    it "assigns @suggested_team" do
      xhr :get, :next_rec
      expect(response).to redirect_to("http://test.host/login")
    end
  end

  describe "prev_rec" do
    it "assigns @suggested_team" do
      xhr :get, :next_rec
      expect(response).to redirect_to("http://test.host/login")
    end
  end
end
