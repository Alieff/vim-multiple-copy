# Feature
This vim plugin allow you to copy text without overwrite previously copied text.
This plugin can also cycle through your copied text, then you can paste any text you want.

#### Demo
![Demo](docs/demo.gif)

# Installation
## Pathogen

Clone this repo to your plugin folder (usually in $HOME/.vim/bundle/)

# How / Usage

| key     | effect                                                                                          |
|---------|-------------------------------------------------------------------------------------------------|
| <a-z>   | clear register z                                                                                |
| <a-c>   | copy then append selected text to register z                                                    |
| <a-x>   | cut then append selected text to register z                                                     |
| <a-o>   | paste text from first queue in register z, register z pointer unchanged                         |
| <a-s-o> | paste text from first queue in register z, then move register z pointer to the next copied text |
| <a-a>   | cycle to the next copied text                                                                   |
| <a-d>   | cycle to the prev copied text                                                                   |

Extra:
- You can also print register z, to print all copied text ('"zp' in normal mode)
