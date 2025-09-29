#!/bin/bash

# This file was empty.
# The main menu calls payload_generator_menu, which is intended to generate payloads.
# The function reverse_shell_generator in exploitation.sh already provides this functionality.
# To avoid code duplication, this menu will act as a direct shortcut to the existing generator.

payload_generator_menu() {
    # This is an alias to the function defined in exploitation.sh
    reverse_shell_generator
}
