#!/bin/bash

# Set default values for environment variables if they are not set
MQTT_PORT=${MQTT_PORT:-1883}

# Check if the required environment variables are set
if [ -z "$MQTT_USERNAME" ] || [ -z "$MQTT_PASSWORD" ]; then
  echo "Error: MQTT_USERNAME and MQTT_PASSWORD must be set"
  exit 1
fi

# Create the Mosquitto password file
echo -n "$MQTT_USERNAME:" >/mosquitto/config/passwd
mosquitto_passwd -b -c /mosquitto/config/passwd "$MQTT_USERNAME" "$MQTT_PASSWORD"

# Set the Mosquitto configuration
cat <<EOF >/mosquitto/config/mosquitto.conf
listener $MQTT_PORT
allow_anonymous false
password_file /mosquitto/config/passwd
EOF

# Start Mosquitto
exec /usr/sbin/mosquitto -c /mosquitto/config/mosquitto.conf
