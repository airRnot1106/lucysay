# lucysay

Lucy has something to say!

<img width="583" height="639" alt="Hello World" src="https://github.com/user-attachments/assets/2159e6dd-ab8f-4be6-be2b-2ee36fc82d09" />

## Usage

```bash
lucysay "Hello World!"

```
```
 _____________
< Hello World! >
 ---------------
       \                                                    
        \                                                   
         \             ........                             
          \           ..:+##-...                            
           \         ...+    *:...                          
            \       ...=       +....                        
             \      ..-#        #-...                       
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
```

### Build from Source

Requirements: [Nix](https://nixos.org/download/)

```bash
# Build for your current platform
nix build

# Run the built executable
./result/bin/lucysay "Your message here"

# Cross-compile for other platforms
nix build .#x86_64-linux     # Linux x86_64
nix build .#aarch64-linux    # Linux ARM64
nix build .#x86_64-darwin    # macOS x86_64
nix build .#aarch64-darwin   # macOS ARM64
```

## LICENSE

MIT
