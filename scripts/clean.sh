#!/bin/bash

find /oss-gif-watermark/www -mtime +5 -not -name "index" -name "*_*" -exec rm {} \;
