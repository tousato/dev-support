describe "GitHub" do

  before do
    visit '/'
  end

  it "トップページが表示されること" do
    expect(page).to have_content('Build software better, together.')
  end
end

