import argv
import gleam/io
import gleam/list
import gleam/string

pub fn format_message(message: String) -> String {
  message
}

fn split_lines(text: String) -> List(String) {
  string.split(text, "\n")
}

fn display_width(text: String) -> Int {
  string.to_utf_codepoints(text)
  |> list.fold(0, fn(width, codepoint) {
    let code = string.utf_codepoint_to_int(codepoint)
    case code {
      _ if code >= 0x1100 && code <= 0x11FF -> width + 2
      _ if code >= 0x2E80 && code <= 0x9FFF -> width + 2
      _ if code >= 0xAC00 && code <= 0xD7AF -> width + 2
      _ if code >= 0xF900 && code <= 0xFAFF -> width + 2
      _ if code >= 0xFE10 && code <= 0xFE19 -> width + 2
      _ if code >= 0xFE30 && code <= 0xFE6F -> width + 2
      _ if code >= 0xFF00 && code <= 0xFF60 -> width + 2
      _ if code >= 0xFFE0 && code <= 0xFFE6 -> width + 2
      _ if code >= 0x20000 && code <= 0x2FFFD -> width + 2
      _ if code >= 0x30000 && code <= 0x3FFFD -> width + 2
      _ -> width + 1
    }
  })
}

fn max_line_width(lines: List(String)) -> Int {
  list.fold(lines, 0, fn(max, line) {
    let width = display_width(line)
    case width > max {
      True -> width
      False -> max
    }
  })
}

fn pad_line(line: String, max_width: Int) -> String {
  let current_width = display_width(line)
  let padding_needed = max_width - current_width
  line <> string.repeat(" ", padding_needed)
}

fn create_top_line(length: Int) -> String {
  " " <> string.repeat("_", length + 2)
}

fn create_bottom_line(length: Int) -> String {
  " " <> string.repeat("-", length + 2)
}

pub fn create_balloon(message: String) -> String {
  let lines = split_lines(message)
  let max_width = max_line_width(lines)
  let top = create_top_line(max_width)
  let bottom = create_bottom_line(max_width)

  case lines {
    [single_line] -> {
      let content = "< " <> pad_line(single_line, max_width) <> " >"
      top <> "\n" <> content <> "\n" <> bottom
    }
    _ -> {
      let balloon_lines =
        list.index_map(lines, fn(line, index) {
          let padded_line = pad_line(line, max_width)
          case index, index == list.length(lines) - 1 {
            0, False -> "/ " <> padded_line <> " \\"
            0, True -> "< " <> padded_line <> " >"
            _, True -> "\\ " <> padded_line <> " /"
            _, False -> "| " <> padded_line <> " |"
          }
        })
      top <> "\n" <> string.join(balloon_lines, "\n") <> "\n" <> bottom
    }
  }
}

pub fn get_ascii_art_with_connector() -> String {
  let art_template =
    "       ?                                                    
        ?                                                   
         ?             ........                             
          ?           ..:+##-...                            
           ?         ...+    *:...                          
            ?       ...=       +....                        
             ?      ..-#        #-...                       
                   ..:*           *:...                     
                  ...=              +....                   
                 ...-#               #+-................... 
                ....#                                   #:..
            .....:=#                                     =..
       .......:*#                                       =...
  ......:=+#                                          #:... 
...:-*#                                              *:..   
..+                                    #@@#         =...    
..:*                ###               +@@@@#      #-...     
 ....-#            =@@@:               #**#      *:...      
    ...:+#         +@@@=                        #-..        
      ....-*                #@:..:@#            #:..        
         ....=#              #+==+#             #=..        
           ....=                                 *:..       
             ...+                                 =...      
             ...-                                 #:..      
              ..:                                  *...     
              ..:#                                  -...    
              ..:*              +=-::-=+*           #:..    
              ..:*           *:.............:-+##   #:..    
              ..:+        *-....         ..............     
              ...+     #-....                     ...       
               ..:*#*-:....                                 
                .......                                     
  "

  string.replace(art_template, "?", "\\")
}

pub fn get_version() -> String {
  "lucysay 0.0.1"
}

pub fn main() -> Nil {
  case argv.load().arguments {
    ["--version"] -> {
      io.println(get_version())
    }
    ["-v"] -> {
      io.println(get_version())
    }
    [message] -> {
      let balloon = create_balloon(message)
      let art = get_ascii_art_with_connector()
      io.println(balloon)
      io.println(art)
    }
    _ -> {
      io.println("Usage: lucysay <message>")
      io.println("       lucysay --version")
    }
  }
}
