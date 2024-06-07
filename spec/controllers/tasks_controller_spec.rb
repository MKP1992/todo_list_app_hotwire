# spec/controllers/tasks_controller_spec.rb
require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:valid_attributes) { { title: "New Task", archived: false } }
  let(:invalid_attributes) { { title: "", archived: false } }

  describe "GET #index" do
    it "returns a success response" do
      create(:task)
      get :index
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, params: { task: valid_attributes }, format: :turbo_stream
        }.to change(Task, :count).by(1)
      end

      it "redirects to the tasks list" do
        post :create, params: { task: valid_attributes }
        expect(response).to redirect_to(tasks_path)
      end

      it "renders the turbo stream response" do
        post :create, params: { task: valid_attributes }, format: :turbo_stream
        expect(flash.now[:notice]).to eq('Task was successfully created.')
      end
    end

    context "with invalid params" do
      it "does not create a new Task" do
        expect {
          post :create, params: { task: invalid_attributes }, format: :turbo_stream
        }.not_to change(Task, :count)
      end

      it "renders the turbo stream response for form" do
        post :create, params: { task: invalid_attributes }, format: :turbo_stream
        expect(response.body).to include('task_form')
      end
    end
  end

  describe "PATCH #update" do
    let(:task) { create(:task) }

    context "with valid params" do
      let(:new_attributes) { { title: "Updated Task" } }

      it "updates the requested task" do
        patch :update, params: { id: task.to_param, task: new_attributes }, format: :turbo_stream
        task.reload
        expect(task.title).to eq("Updated Task")
      end

      it "redirects to the tasks list" do
        patch :update, params: { id: task.to_param, task: new_attributes }
        expect(response).to redirect_to(tasks_path)
      end

      it "renders the turbo stream response" do
        patch :update, params: { id: task.to_param, task: new_attributes }, format: :turbo_stream
        expect(flash.now[:notice]).to eq('Task was successfully updated.')
      end
    end

    context "with invalid params" do
      it "renders the turbo stream response for form" do
        patch :update, params: { id: task.to_param, task: invalid_attributes }, format: :turbo_stream
        expect(response.body).to include("task_#{task.to_param}")
      end
    end
  end
end
