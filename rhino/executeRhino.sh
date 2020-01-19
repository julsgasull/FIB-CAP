#!/bin/bash
javac -cp dades/linux/CAP/rhino1.7.11/lib/rhino-1.7.11.jar "$@"
java -cp dades/linux/CAP/rhino1.7.11/lib/rhino-1.7.11.jar "$@"