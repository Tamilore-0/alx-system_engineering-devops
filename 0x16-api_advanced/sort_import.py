#!/usr/bin/python3
"""
Script arranges VALID imports in a sorted order
ASSUMING ALL IMPORTS ARE AT THE START OF THE LINE
"""
import sys
import re
from fabric.api import local


# ANSI escape code for red text
RED = "\033[31m"
# ANSI escape code for green text
GREEN = "\033[32m"
# ANSI escape code for blue text
BLUE = "\033[34m"
# ANSI escape code for resetting text color to default
RESET = "\033[0m"

if len(sys.argv) < 2:
    print(f"USAGE: {sys.argv[0]} <filename>")
else:
    filename = sys.argv[1]
    try:
        unsorted_imports = {}
        with open(filename, 'r') as file:
            count = 0
            for _ in range(15):
                count += 1
                line = str(file.readline())
                store = re.findall(r'^\s*import\s+\w+$', line,
                                   flags=re.MULTILINE)
                if store:
                    line_number = count
                    unsorted_imports[line_number] = store[0].strip()
        if not unsorted_imports:
            print(RED + "There are no imports in the file" + RESET)
            exit(0)
        sorted_imports = sorted(unsorted_imports.values())
        if [value for value in unsorted_imports.values()] == sorted_imports:
            print(GREEN + "Imports already sorted" + RESET)
            exit(0)

        print(BLUE + "Arranging imports..." + RESET)
        for i, (line, value) in enumerate(unsorted_imports.items()):
            local(fr'sed -i "{line}s/\s*{unsorted_imports[line]}'
                  f'/{sorted_imports[i]}/g" {filename}')
        print(BLUE + "done." + RESET)
    except FileNotFoundError:
        print(RED + "Error: File probably doesnt exist" + RESET)
        exit(1)
