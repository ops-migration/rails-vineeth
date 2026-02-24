module Api
  module V1
    class TasksController < BaseController
      before_action :set_task, only: [:show, :update, :destroy]

      # GET /api/v1/tasks
      def index
        tasks = Task.recent.by_status(params[:status])
        render json: {
          data: tasks.map { |t| task_json(t) },
          meta: {
            total: tasks.count,
            status_filter: params[:status]
          }
        }
      end

      # GET /api/v1/tasks/:id
      def show
        render json: { data: task_json(@task) }
      end

      # POST /api/v1/tasks
      def create
        task = Task.new(task_params)
        if task.save
          render json: { data: task_json(task), message: "Task created successfully" }, status: :created
        else
          render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/tasks/:id
      def update
        if @task.update(task_params)
          render json: { data: task_json(@task), message: "Task updated successfully" }
        else
          render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/tasks/:id
      def destroy
        @task.destroy
        render json: { message: "Task deleted successfully" }
      end

      private

      def set_task
        @task = Task.find(params[:id])
      end

      def task_params
        params.require(:task).permit(:title, :description, :status, :due_date)
      end

      def task_json(task)
        {
          id: task.id,
          title: task.title,
          description: task.description,
          status: task.status,
          due_date: task.due_date,
          created_at: task.created_at,
          updated_at: task.updated_at
        }
      end
    end
  end
end
