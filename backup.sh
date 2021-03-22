#!/bin/bash 

cp /home/ubuntu/rails-chat-channel/db/development.sqlite3 /home/ubuntu/rails-chat-channel/
cd /home/ubuntu/rails-chat-channel/
git add .
git commit -m "backup"
git push
