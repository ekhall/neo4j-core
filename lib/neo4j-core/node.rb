require "helpers/argument_helpers"
require "neo4j-core/node/rest"

module Neo4j
  module Node
    extend Neo4j::ArgumentHelpers

    class << self
      def new(attributes, *args)
        session = extract_session(args)
        labels = args.flatten

        begin
          session.create_node(attributes, labels)
        rescue NoMethodError
          raise_invalid_session_error(session)
        end
      end

      def load(id, session = Neo4j::Session.current)
        begin
          session.load(id)
        rescue NoMethodError
          raise_invalid_session_error(session)
        end
      end

      private
        def raise_invalid_session_error(session)
          raise Neo4j::Session::InvalidSessionTypeError.new(session.class)
        end
    end
  end
end