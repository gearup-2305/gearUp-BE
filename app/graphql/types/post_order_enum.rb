module Types
  class PostOrderEnum < GraphQL::Schema::Enum
    value "ASC", "Sort by ascending order"
    value "DESC", "Sort by descending order"
  end
end
