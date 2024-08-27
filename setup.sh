#!/bin/bash

echo "—————— Building the Docker container/image... ——————"
docker compose build

echo "—————— Setting up and seeding the database... ——————"
docker compose run web rails db:setup db:migrate db:seed

echo "—————— Spinning up the application... ——————"
docker compose up