# Base methods for CRUD actions
# Simply override any methods in your action controller you want to be customised
# Don't forget to add:
#   resources :plural_model_name_here
# to your routes.rb file.
# Full documentation about CRUD and resources start here:
# -> http://www.google.com/search?q=rails%20REST
# Example (add to your controller):
# crudify :foo, { :title_attribute => 'name' }


module Crudify

  module Base

    def self.default_options(model_name)
      singular_name = model_name.to_s
      class_name = singular_name.camelize
      plural_name = singular_name.pluralize
      this_class = class_name.constantize
      {
        :title_attribute => "title",
        :use_class_name_as_title => false,
        :paginate => true,
        :sortable => true,
        :searchable => true,
        :include => [],
        # :order => ('position ASC' if this_class.table_exists? && this_class.column_names.include?('position')), # FIXME
        :conditions => '',
        :search_conditions => '',
        :redirect_to_url => "admin_#{plural_name}_url", # FIXME
        :log => Rails.env == 'development'
      }
    end
  
    def self.append_features(base)
      super
      base.send(:include, Crudify::HookMethods)
      base.extend(Crudify::ClassMethods)
    end
  
  end

end
