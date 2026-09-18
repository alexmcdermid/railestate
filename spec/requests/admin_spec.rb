require "rails_helper"

RSpec.describe "Admin visits", type: :request do
  include Devise::Test::IntegrationHelpers

  let(:admin) { users(:one) }

  before do
    allow(ENV).to receive(:[]).and_call_original
    allow(ENV).to receive(:[]).with("ADMIN_EMAILS").and_return(admin.email)
    allow(Ahoy).to receive(:server_side_visits).and_return(false)
  end

  describe "GET /admin/index" do
    it "redirects unauthenticated visitors" do
      get admin_index_path

      expect(response).to redirect_to(root_path)
    end

    it "redirects signed-in users who are not admins" do
      sign_in users(:two)
      get admin_index_path

      expect(response).to redirect_to(root_path)
    end

    context "as an admin" do
      before { sign_in admin }

      let!(:visits) do
        Array.new(41) do
          Ahoy::Visit.create!(
            visit_token: SecureRandom.uuid,
            visitor_token: SecureRandom.uuid,
            started_at: Time.current,
            user: admin
          )
        end
      end

      it "renders real pagination links and the first 20 visits" do
        get admin_index_path
        document = Nokogiri::HTML(response.body)

        expect(response).to have_http_status(:ok)
        expect(document.css("nav.pagy-bootstrap ul.pagination").size).to eq(1)
        expect(document.at_css('.page-item.next a')["href"]).to eq("/admin/index?page=2")
        expect(document.css("tbody tr td:first-child").map { |cell| cell.text.to_i })
          .to eq(visits.first(20).map(&:id))
        expect(document.at_css(".pagy-navigation").text).to include("Showing entries 1 to 20 of 41.")
      end

      it "returns the next 20 visits in stable order without repeating the first page" do
        get admin_index_path, params: { page: 2 }
        document = Nokogiri::HTML(response.body)

        expect(response).to have_http_status(:ok)
        expect(document.css("tbody tr td:first-child").map { |cell| cell.text.to_i })
          .to eq(visits.slice(20, 20).map(&:id))
        expect(document.at_css('[aria-current="page"]').text).to eq("2")
        expect(document.at_css(".pagy-navigation").text).to include("Showing entries 21 to 40 of 41.")
      end

      it "renders the final partial page" do
        get admin_index_path, params: { page: 3 }
        document = Nokogiri::HTML(response.body)

        expect(response).to have_http_status(:ok)
        expect(document.css("tbody tr td:first-child").map { |cell| cell.text.to_i })
          .to eq([visits.last.id])
        expect(document.at_css('.page-item.next a[aria-disabled="true"]')).not_to be_nil
        expect(document.at_css(".pagy-navigation").text).to include("Showing entries 41 to 41 of 41.")
      end

      it "continues escaping untrusted visit fields" do
        payload = '<script>alert("visit")</script>'
        visits.first.update!(user_agent: payload, referrer: payload)

        get admin_index_path
        document = Nokogiri::HTML(response.body)

        expect(response).to have_http_status(:ok)
        expect(document.css("tbody script")).to be_empty
        expect(document.at_css("tbody").text).to include(payload)
        expect(response.body).to include("&lt;script&gt;")
      end
    end
  end
end
