kubectl create secret generic rails-secrets \
  --from-literal=DATABASE_USERNAME=postgres \
  --from-literal=DATABASE_PASSWORD="" \
  --from-literal=RAILS_MASTER_KEY=ea3aaacc43f832b6e9049e61211561dc
