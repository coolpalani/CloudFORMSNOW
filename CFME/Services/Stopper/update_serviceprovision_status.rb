#
# Description: This method updates the service provisioning status
# Required inputs: status
#


prov = $evm.root['service_template_provision_task']

# Get status from input field status
status = $evm.inputs['status']


# Bypass errors for Invalid instances
if prov.message == 'Invalid'
  $evm.log("info","Skipping Invalid Services")
  $evm.root['ae_result'] = 'ok'
  message = 'Service Provisioned Successfully'
  prov.finished(prov.message)
  exit MIQ_OK
end


# Update Status for on_entry,on_exit
if $evm.root['ae_result'] == 'ok'

  # Check to see if provisioning is complete
  if status == 'provision_complete'
    message = 'Service Provisioned Successfully'
    prov.finished(message)
  end
  prov.message = status
end

# Update Status for on_error
if $evm.root['ae_result'] == 'error'
  prov.message = status
end



