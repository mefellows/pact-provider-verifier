bundle exec rackup -p 4567 script/dev/bar_provider_config.ru 2> /dev/null &
pid=$!
sleep 3

export PACT_BROKER_PACTS_FOR_VERIFICATION_ENABLED=true

bundle exec bin/pact-provider-verifier  \
  https://test.pact.dius.com.au/pacts/provider/trip-service/consumer/billing-service/latest \
  --broker-username dXfltyFMgNOFZAxr8io9wJ37iUpY42M \
  --broker-password O5AIZWxelWbLvqMd8PkAVycBJh2Psyg1 \
  --provider-base-url http://localhost:4567 \
  --provider-states-setup-url http://localhost:4567/provider-state \
  --format progress

kill -2 $pid
wait $pid
