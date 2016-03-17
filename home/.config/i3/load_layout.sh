#!/bin/bash

# First we append the saved layout of worspace N to workspace M
i3-msg "workspace 1; append_layout ~/.config/i3/workspace_1.json"

# And finally we fill the containers with the programs they had
(urxvtc &)
(urxvtc &)
(urxvtc &)

i3-msg "workspace 3; append_layout ~/.config/i3/workspace_3.json"

(urxvtc &)
(urxvtc -name rtorrent -e rtorrent &)
