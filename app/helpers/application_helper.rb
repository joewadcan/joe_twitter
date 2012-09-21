module ApplicationHelper

def full_title(page_title)
	base_title = "Joe Twitter"
	if page_title.empty?
		then
		base_title
	else
		"#{base_title} | #{page_title}"
	end
end



end
