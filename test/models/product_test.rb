require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image].any? # Można usunąć, jeśli image nie jest wymagane
  end

  test "product price must be positive" do
    product = Product.new(title: "My Book Title",
                          description: "yyy")

    file_path = "test/fixtures/files/lorem.jpg"
    if File.exist?(file_path)
      product.image.attach(io: File.open(file_path),
                           filename: "lorem.jpg",
                           content_type: "image/jpeg")
    else
      raise "Plik lorem.jpg nie istnieje w test/fixtures/files/"
    end

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end
end