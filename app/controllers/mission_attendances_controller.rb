class MissionAttendancesController < AuthorizedController
  inherit_resources
  actions :index, :show, :edit, :update
  custom_actions resource: :empty

  # PUT empty
  # Empties report
  def empty
    resource.report = nil
    update! { collection_url }
  end
end
