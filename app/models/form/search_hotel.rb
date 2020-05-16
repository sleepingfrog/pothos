module Form
  class SearchHotel
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :food, :string
    attribute :staff, :string
    attribute :guest, :string

    def default_scope
      Hotel.all
    end

    def search
      scope = default_scope
      attributes.each do |key, value|
        scope = build_search_query(key, scope, value)
      end

      scope
    end

    private
    def build_search_query(key, scope, value)
      query_method = :"build_query_#{key}"
      send(query_method, scope, value)
    end

    %w[food staff guest].each do |key|
      define_method "build_query_#{key}" do |scope, value|
        build_insect_search_query(key, scope, value)
      end
    end

    def build_insect_search_query(key, scope, value)
      if value.blank?
        return scope
      end

      association = scope.model.reflect_on_association(key)
      klass = association.klass
      table = klass.arel_table.alias(key.to_s.pluralize)
      foreign_key = association.foreign_key
      select_arel = scope.arel_table

      value_string = "%#{escape_like(value)}%"
      join_source = scope
        .arel
        .join(table, Arel::Nodes::InnerJoin).on(
          select_arel[foreign_key].eq(table[klass.primary_key])
        )
        .join_sources

      scope
        .joins(join_source)
        .where(table[:name].matches(value_string, nil, true))
    end

    def escape_like(string)
      string.gsub(/[\\%_]/) { |m| "\\#{m}" }
    end
  end
end
