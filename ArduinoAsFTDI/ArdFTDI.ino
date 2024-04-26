void setup() {
  Serial.begin(115200); // Set baud rate to match the DE10-Lite UART configuration
}

void loop() {
  if (Serial.available()) {
    // If data is available from the DE10-Lite board
    char data = Serial.read(); // Read the incoming byte
    // Transmit the received byte back to the DE10-Lite board for confirmation
    Serial.write(data);
  }
}
