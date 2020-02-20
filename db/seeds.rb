unless Rails.env.development?
  puts "".center(30, "*")
  puts "only development"
  puts "".center(30, "*")

  exit
end

1.upto(3) do |i|
  Post.create!(
    title: "post_#{i}",
    body: "post_body#{i}"
  )
end

1.upto(3) do |i|
  a = Author.new(
    name: "author_#{i}",
    age: i * 10
  )

  1.upto(3) do |j| 
    a.books.build(
      name: "a_#{i}_b_#{j}"
    )
  end

  a.save!
end
