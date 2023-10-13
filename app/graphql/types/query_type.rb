# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: "Fetches an object given its ID." do
      argument :id, ID, required: true, description: "ID of the object."
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, null: true], null: true, description: "Fetches a list of objects given a list of IDs." do
      argument :ids, [ID], required: true, description: "IDs of the objects."
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    field :artists, [Types::ArtistType], null: false 
      
    def artists
      Artist.includes(:posts).all
    end

    field :artist, Types::ArtistType, null: false do
      argument :id, ID, required: true
    end
    
    def artist(id:)
      Artist.includes(:posts).find(id)
    end 
  end
end
