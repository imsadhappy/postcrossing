# app/models/user_groups.rb
module UserGroups
  def admin?
    is 'admin'
  end

  def is(group)
    in_group "#{group}s"
  end

  def in_group(group)
    groups.split(',').include? group.to_s.downcase
  end

  def add_to(group)
    group = group.to_s.downcase
    return false if in_group group

    self.groups += ",#{group}"
    save
  end

  def remove_from(group)
    group = group.to_s.downcase
    return false if group == 'users'

    groups = self.groups.split(',')
    return false unless groups.include? group

    groups.delete(group)
    self.groups = groups.join(',')
    save
  end
end
