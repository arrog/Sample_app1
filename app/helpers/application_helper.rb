module ApplicationHelper
  # Returns the full title on a per-page basis.
    def full_title(page_title)
      base_title = "Ruby on Rails Tutorial Sample App"
      if page_title.empty?
        base_title
      else
        "#{base_title} | #{page_title}"
      end
    end
    
    def link_to_add_fields(name, f, association)
        new_object = f.object.send(association).klass.new
        id = new_object.object_id
        fields = f.fields_for(association, new_object, child_index: id) do |builder|
          render(association.to_s.singularize + "_fields", f: builder)
        end
        link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
    end
    
    def resource_name
     :user
    end
    
    def cp(path)
      if current_page?(path)
        "active"
      else
        "text3"
      end
    end
    
    def resource
     @resource ||= User.new
    end
    
    def devise_mapping
     @devise_mapping ||= Devise.mappings[:user]
    end
    
    def pageless(total_pages, url=nil, container=nil)
       opts = {
         :totalPages => total_pages,
         :url        => url,
         :loaderMsg  => 'Chargement ...',
         :loaderImage => image_path("logo.png")
       }

       container && opts[:container] ||= container

       javascript_tag("$('#results').pageless(#{opts.to_json});")
     end
 
end



