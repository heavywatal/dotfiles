#!/bin/sh
sed -E "s|(amazon\.[^/]+).*?(/dp/[^/]+)/.*|\1\2\n|"
