#!/bin/sh
sd '(amazon\.[^/]+).*?/(dp|gp/product)/([^/?]+).*' '$1/dp/$3'
