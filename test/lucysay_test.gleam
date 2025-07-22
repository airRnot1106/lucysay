import gleeunit
import lucysay

pub fn main() -> Nil {
  gleeunit.main()
}

pub fn format_message_test() {
  let result = lucysay.format_message("Hello")
  assert result == "Hello"
}
