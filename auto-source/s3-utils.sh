function ensure_bucket_exists() {
  local function_name="ensure_bucket_exists" bucket region exit_on_forbidden="false" exit_on_error="true";
  import_args "$@";
  check_required_arguments "$function_name" bucket region;
  log_info "Checking if bucket '$bucket' exists.";
  local output="$(aws s3api head-bucket --bucket "$bucket" 2>&1;)";

  if echo "$output" | grep " HeadBucket " >/dev/null; then
    if echo "$output" | grep "(403)" >/dev/null; then
      log_warn "The currently used AWS credentials doesn't have HeadBucket permissions for the existing bucket '$bucket'.";
      log_warn "This might be OK though because other required credentials, like reading from the bucket, might be assigned";
      if [ "$exit_on_forbidden" == "true" ]; then
        log_info "Exiting with an error because argument 'exit_on_forbidden' is 'true'.";
        exit 1;
      else
        log_info "Not exiting with an error because argument 'exit_on_forbidden' is not 'true'.";
      fi;
    elif echo "$output" | grep "(404)" >/dev/null; then
      log_info "Bucket '$bucket' doesn't exist. Trying to create it.";
      aws s3api create-bucket --bucket "$bucket" --region "$region" \
        --create-bucket-configuration LocationConstraint=$region;
    else
      log_error "Unable to determine if bucket '$bucket' exists using HeadBucket. Error is:";
      echo "$output";
      if [ "$exit_on_error" == "true" ]; then
        log_info "Exiting because argument 'exit_on_error' for function '$function_name' as default value 'true'.";
        exit 1;
      fi;
    fi;
  else
    log_info "Bucket '$bucket' exists.";
  fi;
  #if aws s3api head-bucket --bucket "$bucket"; then
  #  log_info "Bucket '$bucket' exists.";
  #else
  #  log_info "Unable to determine if bucket '$bucket' exists. Trying to create it in region $region.";
  #fi;
}