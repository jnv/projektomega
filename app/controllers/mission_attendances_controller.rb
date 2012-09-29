class MissionAttendancesController < AuthorizedController
  inherit_resources
  actions :index, :show, :edit, :update
end
