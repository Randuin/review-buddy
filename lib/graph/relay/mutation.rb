module Graph
  module Relay
    class Mutation
      class << self
        attr_accessor :resolve, :description

        def type_name
          @type_name ||= name.split('::').last 
        end

        def field
          @field ||= begin
            field_return_type = return_type
            field_input_type = input_type
            field_resolve_proc = lambda do |obj, args, ctx|
              result = @resolve.call(obj, args[:input], ctx)
              result[:clientMutationId] = args[:input][:clientMutationId]
              Result.new(result)
            end

            GraphQL::Field.define do
              type(field_return_type)  
              argument :input, !field_input_type
              resolve(field_resolve)
            end
          end
        end

        def input(name, type, description: nil, default_value: nil)
          input_type.arguments[name] = GraphQL::Argument.define do
            name(name)
            type(type)
            description(description)
            default_value(default_value)
          end 
        end

        def returns(name, type, description: nil)
          return_type.fields[name] = GraphQL::Field.define do
            name(name)
            type(type)
            description(description)
          end
        end

        def input_type 
          @input_type ||= begin
            input_name = "#{type_name}Input"
            GraphQL::InputObjectType.define do
              name(input_name)
              description("Input type for #{input_name}")
              input_field :clientMutationId, !types.String
            end
          end
        end

        def return_type
          @return_type ||= begin
            payload_name = "#{type_name}Payload"
            GraphQL::ObjectType.define do
              name(payload_name)
              description("Payload for mutation #{payload_name}")
              field :clientMutationId, !types.String
            end
          end
        end
      end

      class Result
        def initialize(results)
         @results = results
        end

        def method_missing(name, *args, &block)
          if results.key(name)
            results[name]
          else
            super
          end
        end
      end
    end
  end
end
            
