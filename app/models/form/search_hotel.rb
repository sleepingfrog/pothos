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

    def build_query_food(scope, value)
      if value.blank?
        return scope
      end
      food_table = Insect.arel_table.alias('foods')
      value_string = "%#{value}%"
      select_arel = scope.arel_table

      join_source = scope
        .arel
        .join(food_table, Arel::Nodes::InnerJoin).on(select_arel[:food_id].eq(food_table[:id]))
        .join_sources

      scope
        .joins(join_source)
        .where(food_table[:name].matches(value_string, nil, true))
    end

    def build_query_staff(scope, value)
      if value.blank?
        return scope
      end
      staff_table = Insect.arel_table.alias('staffs')
      value_string = "%#{value}%"
      select_arel = scope.arel_table

      join_source = scope
        .arel
        .join(staff_table, Arel::Nodes::InnerJoin).on(select_arel[:staff_id].eq(staff_table[:id]))
        .join_sources

      scope
        .joins(join_source)
        .where(staff_table[:name].matches(value_string))
    end

    def build_query_guest(scope, value)
      if value.blank?
        return scope
      end
      guest_table = Insect.arel_table.alias('guests')
      value_string = "%#{value}%"
      select_arel = scope.arel_table

      join_source = scope
        .arel
        .join(guest_table, Arel::Nodes::InnerJoin).on(select_arel[:guest_id].eq(guest_table[:id]))
        .join_sources

      scope
        .joins(join_source)
        .where(guest_table[:name].matches(value_string, nil, true))
    end
  end
end
