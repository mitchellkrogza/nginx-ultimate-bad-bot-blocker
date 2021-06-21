#!/bin/bash

if [[ ! -z "$(git status --porcelain)" ]]
then
    echo "push"
else
echo "do nothing"
fi
