#!/bin/bash
tar --remove-files --create --file - "$1" -P | pv -s $(du -sb "$1" | awk '{print $1}')  > "$1".tar
