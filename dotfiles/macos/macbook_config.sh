# The key repeat rate controls how quickly a key repeats when you hold it down.
# Set Key Repeat Rate:
defaults write -g KeyRepeat -int 2

# Verify the Current Setting:
defaults read -g KeyRepeat


# The delay until repeat controls how long you need to hold a key before it starts repeating.
# Set Delay Until Repeat:
defaults write -g InitialKeyRepeat -int 15 

# Verify the Current Setting:
defaults read -g InitialKeyRepeat
