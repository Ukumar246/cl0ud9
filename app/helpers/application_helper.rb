module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, :sort => column, :direction => direction
  end

  def tournament_show_with_privacy(tournament)
      link_to tournament_url_with_privacy(tournament)
  end

  def tournament_url_with_privacy(tournament)
  	if tournament.privateURL?
      url_for(controller: 'tournaments', action: 'private_url', key: tournament.private_url.key, id: tournament.id, only_path: false)
    else
      url_for(controller: 'tournaments', action: 'show', id: tournament.id, only_path: false)
    end
  end
end
