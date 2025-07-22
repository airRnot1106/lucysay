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

fn max_line_length(lines: List(String)) -> Int {
  list.fold(lines, 0, fn(max, line) {
    let length = string.length(line)
    case length > max {
      True -> length
      False -> max
    }
  })
}

fn pad_line(line: String, max_length: Int) -> String {
  let padding_needed = max_length - string.length(line)
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
  let max_length = max_line_length(lines)
  let top = create_top_line(max_length)
  let bottom = create_bottom_line(max_length)

  case lines {
    [single_line] -> {
      let content = "< " <> pad_line(single_line, max_length) <> " >"
      top <> "\n" <> content <> "\n" <> bottom
    }
    _ -> {
      let balloon_lines =
        list.index_map(lines, fn(line, index) {
          let padded_line = pad_line(line, max_length)
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

pub fn get_ascii_art() -> String {
  "                       ........                             
                      ..:+##-...                            
                     ...+    *:...                          
                    ...=       +....                        
                    ..-#        #-...                       
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
                ......."
}

pub fn main() -> Nil {
  case argv.load().arguments {
    [message] -> {
      let balloon = create_balloon(message)
      let art = get_ascii_art()
      io.println(balloon)
      io.println(art)
    }
    _ -> {
      io.println("Usage: lucysay <message>")
    }
  }
}
