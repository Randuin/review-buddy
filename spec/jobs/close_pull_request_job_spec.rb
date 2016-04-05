require 'rails_helper'

RSpec.describe ClosePullRequestJob, :type => :job do
  describe "#perform" do
    context "when pr exists" do
      let(:pr) {
        build(:pull_request, number: 1, repo: 'repo', owner: 'owner')
      }

      context "when pr is merged" do
        let(:params) {
          {
            number: 1,
            pull_request: {
              merged: true,
            },
            repository: {
              name: 'repo',
              owner: {
                login: 'owner'
              }
            }
          }
        }

        it "it closes the pull request and marks it as merged" do
          pr.save!
          ClosePullRequestJob.new.perform(params)
          expect(pr.reload.closed).to be(true)
          expect(pr.merged).to be(true)
        end
      end

      context "when pr is closed but not merged" do
        let(:params) {
          {
            number: 1,
            pull_request: {
              merged: false,
            },
            repository: {
              name: 'repo',
              owner: {
                login: 'owner'
              }
            }
          }
        }

        it "it closes the pr but does not mark it as marged" do
          pr.save!
          ClosePullRequestJob.new.perform(params)
          expect(pr.reload.closed).to be(true)
          expect(pr.merged).to be(false)
        end 
      end
    end
  end
end
