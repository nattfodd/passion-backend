# frozen_string_literal: true

class Category::Create < CreateWithUniqNameBase
  private

  def model_class
    Category
  end
end
