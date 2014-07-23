#!/bin/bash

# Check if nzbget.conf exists. If not, copy sample config
if [ -f /config/nzbget.conf ]; then
  echo "nzbget.conf exists"
else
  cp /usr/share/nzbget/nzbget.conf /config/
  chown nobody:users /config/nzbget.conf
fi
