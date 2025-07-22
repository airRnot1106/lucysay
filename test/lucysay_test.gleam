import gleeunit
import lucysay

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn format_message_test() {
  let result = lucysay.format_message("Hello")
  assert result == "Hello"
}

pub fn create_balloon_test() {
  let result = lucysay.create_balloon("Hello")
  let expected = "< Hello >"
  assert result == expected
}

pub fn get_ascii_art_test() {
  let result = lucysay.get_ascii_art()
  assert result != ""
}
