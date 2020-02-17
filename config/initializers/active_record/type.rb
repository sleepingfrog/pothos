class PostTitle < ActiveRecord::Type::String
  def cast_value(value)
    value = super(value)

    replace_circled_number(value)
  end

  def replace_circled_number(value)
    circled_zero             = "\u{24ea}"
    circled_1_to_10          = "\u{2460}-\u{2469}"
    negative_circled_zero    = "\u{24ff}"
    negative_circled_1_to_10 = "\u{2776}-\u{277F}"

    [
      ["\u{1f10b}",         circled_zero            ], # sans-serif 0
      ["\u{2780}-\u{2789}", circled_1_to_10         ], # sans-serif 1-10
      ["\u{1f10c}",         negative_circled_zero   ], # negative circled sans-serif 0
      ["\u{278a}-\u{2793}", negative_circled_1_to_10], # negative circled sans-serif 1-10
    ].each_with_object(value.dup) do |(from, to), str|
      str.tr!(from, to)
    end
  end
end

ActiveRecord::Type.register(:post_title, PostTitle)
