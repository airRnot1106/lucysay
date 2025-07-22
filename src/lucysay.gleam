import gleam/io

pub fn format_message(message: String) -> String {
  message
}

pub fn create_balloon(message: String) -> String {
  "< " <> message <> " >"
}

pub fn main() -> Nil {
  io.println("Hello from lucysay!")
}
