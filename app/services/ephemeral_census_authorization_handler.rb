# frozen_string_literal: true

# A subclass of CensusAuthorizationHandler for ephemeral verification workflows.
# It reuses the census fields and validations (document number and date of birth)
# and excludes tos_agreement from form_attributes because the verifications view
# already renders it as a proper checkbox via the _tos_acceptance_field partial.
#
# The class name matches the workflow registration name (:ephemeral_census_authorization_handler)
# so that handler_name is consistent across the hidden field, the authorization record,
# and the permission check.
class EphemeralCensusAuthorizationHandler < CensusAuthorizationHandler
  def form_attributes
    attributes.except(*%w(id user tos_agreement)).keys
  end

  def handler_name
    +"ephemeral_census_authorization_handler"
  end
end
