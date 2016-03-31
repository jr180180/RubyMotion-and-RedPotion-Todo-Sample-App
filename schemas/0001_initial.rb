schema "0001 initial" do

  entity "Task" do
    # Define anything you want to here
    string :name, optional: false

    # These are special CDQ properties that get populated automatically.
    # They are not required, but are very helpful.
    datetime :created_at
    datetime :updated_at
  end

end
