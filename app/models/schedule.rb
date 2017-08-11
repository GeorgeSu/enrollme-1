class Schedule < ActiveRecord::Base
  belongs_to :user

  @@feature_cols = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  def toArray
    arr = []
    @@feature_cols.each do |col|
      if self[col]
        arr.push(1)
      else
        arr.push(0)
      end
    end
    return arr
  end

  def toString
    return (@@feature_cols.select {|day| self[day] == 1}).map {|str| str.capitalize}.join(', ')
  end

  def self.feature_cols
    return @@feature_cols
  end
end
