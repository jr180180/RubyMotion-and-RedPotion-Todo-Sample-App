class HomeScreen < PM::DataTableScreen
  title "Task List"
  stylesheet HomeScreenStylesheet
  model Task

  def on_load
    set_nav_bar_button :left, title: 'Clear List', action: :clear_list
    set_nav_bar_button :right, title: "Add Task", action: :add_task
  end

  def clear_list
    Task.all.each do |t|
      t.destroy
    end
    cdq.save
  end

  def add_task
    app.alert(title: "Add Task", message: "What would you like to do?", style: :input, text: "todo", placeholder: "Add Todo name here") do |action_type, fields|
      if fields[:text].text != ''
        Task.create(name: "#{fields[:text].text}")
        cdq.save
      else
        app.alert('Task not create. Please be sure to enter a name.')
      end
    end
  end

  def on_cell_deleted(cell, index_path)
    mp index_path.row
    Task.all[index_path.row].destroy
    cdq.save
    
    false
  end


  # You don't have to reapply styles to all UIViews, if you want to optimize, another way to do it
  # is tag the views you need to restyle in your stylesheet, then only reapply the tagged views, like so:
  #   def logo(st)
  #     st.frame = {t: 10, w: 200, h: 96}
  #     st.centered = :horizontal
  #     st.image = image.resource('logo')
  #     st.tag(:reapply_style)
  #   end
  #
  # Then in will_animate_rotate
  #   find(:reapply_style).reapply_styles#

  # Remove the following if you're only using portrait
  def will_animate_rotate(orientation, duration)
    find.all.reapply_styles
  end
end
