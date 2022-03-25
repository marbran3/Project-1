#!/bin/bash

awk '{print FILENAME, $1, $2, $5, $6}' $1 | grep -i '05:00:00 AM' >> Dealers_working_during_losses
awk '{print FILENAME, $1, $2, $5, $6}' $1 | grep -i '08:00:00 AM' >> Dealers_working_during_losses
awk '{print FILENAME, $1, $2, $5, $6}' $1 | grep -i '02:00:00 PM' >> Dealers_working_during_losses

