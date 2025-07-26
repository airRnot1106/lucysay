import gleam/string
import gleeunit
import lucysay

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn format_message_test() {
  let result = lucysay.format_message("Hello")
  assert result == "Hello"
}

pub fn create_balloon_single_line_test() {
  let result = lucysay.create_balloon("Hello")
  let expected = " _______\n< Hello >\n -------"
  assert result == expected
}

pub fn create_balloon_multi_line_test() {
  let result = lucysay.create_balloon("Line1\nLine2")
  let expected = " _______\n/ Line1 \\\n\\ Line2 /\n -------"
  assert result == expected
}

pub fn get_ascii_art_with_connector_test() {
  let result = lucysay.get_ascii_art_with_connector()
  assert string.contains(result, "\\")
  assert !string.contains(result, "$T")
}

pub fn create_balloon_japanese_test() {
  let result = lucysay.create_balloon("こんにちは")
  let expected = " ____________\n< こんにちは >\n ------------"
  assert result == expected
}
