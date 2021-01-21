#!/usr/bin/env bash

awk '/$SUBNAME/{getline;getline;print $2}
