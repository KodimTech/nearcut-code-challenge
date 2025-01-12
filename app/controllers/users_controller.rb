class UsersController < ApplicationController
  def create
    service = Users::FileUpload.new(params[:file])

    render turbo_stream: turbo_stream.replace(
      "results",
      render_to_string(::Forms::FileUpload::ResultsComponent.new(results: service.perform))
    )
  end
end
