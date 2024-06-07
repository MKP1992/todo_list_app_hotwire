require 'rails_helper'

RSpec.describe Task, type: :model do
  describe "validations" do
    it "is valid with a title" do
      task = Task.new(title: "Example Task")
      expect(task).to be_valid
    end

    it "is invalid without a title" do
      task = Task.new(title: nil)
      expect(task).not_to be_valid
      expect(task.errors[:title]).to include("can't be blank")
    end
  end

  describe "default scope" do
    it "orders tasks by created_at in descending order" do
      task1 = create(:task, created_at: 2.days.ago)
      task2 = create(:task, created_at: 1.day.ago)
      task3 = create(:task, created_at: Time.current)

      expect(Task.all).to eq([task3, task2, task1])
    end
  end
end
