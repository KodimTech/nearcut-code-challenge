# frozen_string_literal: true

class ::Forms::FileUpload::ResultsComponent < ViewComponent::Base
  attr_accessor :results

  def initialize(results:)
    @results = results
  end
end
