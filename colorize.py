import re
import sys

# ANSI escape codes to terminal color mappings
# ansi_escape = re.compile(r'\033\[[0-?]*[ -/]*[@-~]')
# ansi_escape = re.compile(r'(\\033\[.*?m)')
def print_log_with_colors(filename):
    with open(filename, 'r', encoding='utf-8') as f:
        for line in f:
            # line = ansi_escape.sub('', line)
            # print(line.replace('\\033', '\033'), end='')
            print(line.replace('�', '\033'), end='')
            # print(line.replace('�', '\033'), end='')

print_log_with_colors(sys.argv[1])
# print('\033[36mHi\033[0m')