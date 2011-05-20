shared_examples_for "admin area" do
  it { should redirect_to :root }
  specify { flash[:alert].should_not be_blank }
end
