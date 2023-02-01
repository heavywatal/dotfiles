#!/bin/sh
sed -E "s@(amazon\.[^/]+).*?/(dp|gp/product)/([^/?]+).*@\1/dp/\3@"
