#!/bin/sh
cd $BASE_DIR/terraform

terraform destroy -auto-approve

cd $BASE_DIR