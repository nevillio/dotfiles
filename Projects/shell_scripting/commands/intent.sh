#!/bin/bash

ssh_box 'export DBUS_SESSION_BUS_ADDRESS=unix:path=/var/run/dbus/system_bus_socket && dbus-monitor "type='signal',sender='onemw.vrex',path='/vrex',interface='com.lgi.rdk.vrex'"' | rg -o --trim --replace '{$1}' '("payload":\{.*]\})'

# {"message":"query_response","transaction_id":3,"result_type":"NDSP_ASR_APP_CMD","NMAS_PRFX_SESSION_ID":"c87f9af6-4698-41f8-9b38-1340960678e3","NMAS_PRFX_TRANSACTION_ID":"3","final_response":1,"status_code":0,"result_format":"nlu_interpretation_results","prompt":"","cadence_regulatable_result":"completeRecognition","nlu_interpretation_results":{"payload_version":"1.0","payload_format":"nlu-base","payload":{"type":"nlu-1.0","interpretations":[{"literal":"Halt","action":{"intent":{"value":"NO_MATCH","confidence":1.0}}}]},"final_response":1,"status":"success"},"audio_transfer_info":{"nss_server":"webapi-plugin","start_time":1741929958465,"end_time":1741929960811,"packages":[],"audio_id":3}}
#
# echo "$input"
# set -x
# input=$(sed 's/\([^:,{]\+\):/"\1":/g' <<< "$input")
# # Quote string values (simple approach - might need refinement for complex cases)
# input=$(sed 's/: \([^,:{}]*\)\([,}]\)/\:"\1"\2/g' <<< "$input")
#
# echo input > $HOME/Projects/lgi/voice-commands.json
