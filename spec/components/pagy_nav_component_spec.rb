require "rails_helper"
require "view_component/test_helpers"

RSpec.describe PagyNavComponent, type: :component do
  include ViewComponent::TestHelpers

  def render_pagination(count: 127, page: 1)
    with_request_url("/admin/index") do
      render_inline(described_class.new(pagy: Pagy.new(count: count, page: page, limit: 20)))
    end
  end

  it "renders pagination elements instead of escaped HTML" do
    fragment = render_pagination

    expect(fragment.css("nav.pagy-bootstrap ul.pagination").size).to eq(1)
    expect(fragment.at_css('a.page-link[href="/admin/index?page=2"]')).not_to be_nil
    expect(fragment.text).not_to include("<nav", "<ul")
    expect(fragment.text).to include("Showing entries 1 to 20 of 127.")
  end

  it "marks the current page and disables Previous on the first page" do
    fragment = render_pagination
    previous = fragment.at_css('.page-item.prev a[aria-disabled="true"]')

    expect(fragment.at_css('[aria-current="page"]').text).to eq("1")
    expect(previous).not_to be_nil
    expect(previous["href"]).to be_nil
  end

  it "renders Previous and Next links and the correct range on a middle page" do
    fragment = render_pagination(page: 2)

    expect(fragment.at_css('.page-item.prev a[href]')).not_to be_nil
    expect(fragment.at_css('.page-item.next a')["href"]).to eq("/admin/index?page=3")
    expect(fragment.at_css('[aria-current="page"]').text).to eq("2")
    expect(fragment.text).to include("Showing entries 21 to 40 of 127.")
  end

  it "disables Next and shows the partial range on the last page" do
    fragment = render_pagination(page: 7)
    next_link = fragment.at_css('.page-item.next a[aria-disabled="true"]')

    expect(fragment.at_css('.page-item.prev a')["href"]).to eq("/admin/index?page=6")
    expect(next_link).not_to be_nil
    expect(next_link["href"]).to be_nil
    expect(fragment.text).to include("Showing entries 121 to 127 of 127.")
  end

  it "preserves other query parameters when linking between pages" do
    fragment = with_request_url("/admin/index?source=dashboard") do
      render_inline(described_class.new(pagy: Pagy.new(count: 127, limit: 20)))
    end
    query = URI.decode_www_form(URI.parse(fragment.at_css('.page-item.next a')["href"]).query).to_h

    expect(query).to include("source" => "dashboard", "page" => "2")
  end

  [0, 20].each do |count|
    it "does not render unnecessary controls for #{count} visits" do
      expect(render_pagination(count: count).css(".pagy-navigation")).to be_empty
    end
  end

  it "does not render when pagination is absent" do
    expect(render_inline(described_class.new(pagy: nil)).css(".pagy-navigation")).to be_empty
  end
end
