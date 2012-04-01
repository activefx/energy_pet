class Simulation
  include Mongoid::Document

  field :day, :type => Integer
  field :date, :type => String
  field :goal_state, :type => Integer
  field :neighbor_state, :type => Integer
  field :baseline_state, :type => Integer
  field :last_month_consumption, :type => Float
  field :last_month_cost, :type => Float
  field :actual_consumption, :type => Float
  field :actual_cost, :type => Float
  field :baseline_consumption, :type => Float
  field :baseline_cost, :type => Float
  field :neighbor_consumption, :type => Float
  field :neighbor_cost, :type => Float

  def self.seed
    SEED_DATA.reverse.each_with_index do |data, index|
      create(
       :day => index + 1,
       :date => Time.parse(data[:date]),
       :actual_consumption => data[:actual_consumption],
       :actual_cost => data[:actual_cost],
       :last_month_consumption => data[:actual_consumption] * SEED_VALUES[index].first,
       :last_month_cost => data[:actual_cost] * SEED_VALUES[index].first,
       :baseline_consumption => data[:actual_consumption] * SEED_VALUES[index].last,
       :baseline_cost => data[:actual_cost] * SEED_VALUES[index].last,
       :neighbor_consumption => data[:actual_consumption] * SEED_VALUES[index][1],
       :neighbor_cost => data[:actual_cost] * SEED_VALUES[index][1]
      )
    end
  end

  def status_coder(value)
    return 0 if value < 0.89
    return 1 if value < 0.92
    return 2 if value < 0.95
    return 3 if value < 0.98
    return 4 if value < 1.02
    return 5 if value < 1.05
    return 6 if value < 1.08
    return 7 if value < 1.11
    8
  end

  def last_month_percentage
    actual_consumption / last_month_consumption
  end

  def last_month_status
    status_coder last_month_percentage
  end

  def neighbor_percentage
    actual_consumption / neighbor_consumption
  end

  def neighbor_status
    status_coder neighbor_percentage
  end

  def baseline_percentage
    actual_consumption / baseline_consumption
  end

  def baseline_status
    status_coder baseline_percentage
  end




SEED_VALUES = [
  [ 0.98, 0.99, 0.98 ],
  [ 1.01, 0.98, 0.97 ],
  [ 1.02, 0.97, 0.96 ],
  [ 1.03, 0.96, 0.95 ],
  [ 0.96, 0.95, 0.94 ],
  [ 0.95, 0.93, 0.92 ],
  [ 0.90, 0.92, 0.91 ],
  [ 0.92, 0.91, 0.90 ],
  [ 0.92, 0.90, 0.89 ],
  [ 0.85, 0.89, 0.88 ],
  [ 0.92, 0.87, 0.86 ],
  [ 0.93, 0.85, 0.86 ],
  [ 0.87, 0.86, 0.87 ],
  [ 0.90, 0.87, 0.88 ],
  [ 0.95, 0.89, 0.90 ],
  [ 0.96, 0.91, 0.92 ],
  [ 0.98, 0.93, 0.94 ],
  [ 0.95, 0.94, 0.95 ],
  [ 1.00, 0.96, 0.97 ],
  [ 0.99, 0.98, 0.99 ],
  [ 1.03, 0.99, 1.00 ],
  [ 1.05, 1.01, 1.02 ],
  [ 1.05, 1.02, 1.03 ],
  [ 1.07, 1.03, 1.04 ],
  [ 1.08, 1.04, 1.05 ],
  [ 1.09, 1.06, 1.07 ],
  [ 1.10, 1.07, 1.08 ],
  [ 1.12, 1.08, 1.09 ],
  [ 1.10, 1.09, 1.10 ],
  [ 1.07, 1.11, 1.12 ],
  [ 1.06, 1.13, 1.14 ]
]

SEED_DATA = [
  {:date => "2011-03-31T06:00:00.000", :actual_cost => 3.64, :actual_consumption => 34.623},
  {:date => "2011-03-30T06:00:00.000", :actual_cost => 3.88, :actual_consumption => 35.746},
  {:date => "2011-03-29T06:00:00.000", :actual_cost => 3.91, :actual_consumption => 36.039},
  {:date => "2011-03-28T06:00:00.000", :actual_cost => 3.84, :actual_consumption => 35.487},
  {:date => "2011-03-27T06:00:00.000", :actual_cost => 3.87, :actual_consumption => 35.672},
  {:date => "2011-03-26T06:00:00.000", :actual_cost => 3.80, :actual_consumption => 35.306},
  {:date => "2011-03-25T06:00:00.000", :actual_cost => 3.06, :actual_consumption => 38.199},
  {:date => "2011-03-24T06:00:00.000", :actual_cost => 3.09, :actual_consumption => 38.677},
  {:date => "2011-03-23T06:00:00.000", :actual_cost => 3.90, :actual_consumption => 36.002},
  {:date => "2011-03-22T06:00:00.000", :actual_cost => 3.96, :actual_consumption => 36.44},
  {:date => "2011-03-21T06:00:00.000", :actual_cost => 3.85, :actual_consumption => 35.339},
  {:date => "2011-03-20T06:00:00.000", :actual_cost => 3.90, :actual_consumption => 35.851},
  {:date => "2011-03-19T06:00:00.000", :actual_cost => 3.83, :actual_consumption => 35.333},
  {:date => "2011-03-18T06:00:00.000", :actual_cost => 3.11, :actual_consumption => 38.83},
  {:date => "2011-03-17T06:00:00.000", :actual_cost => 3.10, :actual_consumption => 38.806},
  {:date => "2011-03-16T06:00:00.000", :actual_cost => 4.06, :actual_consumption => 37.232},
  {:date => "2011-03-15T06:00:00.000", :actual_cost => 3.84, :actual_consumption => 35.462},
  {:date => "2011-03-14T06:00:00.000", :actual_cost => 3.89, :actual_consumption => 35.957},
  {:date => "2011-03-13T06:00:00.000", :actual_cost => 3.74, :actual_consumption => 34.612},
  {:date => "2011-03-12T06:00:00.000", :actual_cost => 3.99, :actual_consumption => 36.644},
  {:date => "2011-03-11T06:00:00.000", :actual_cost => 2.97, :actual_consumption => 37.109},
  {:date => "2011-03-10T06:00:00.000", :actual_cost => 3.16, :actual_consumption => 39.464},
  {:date => "2011-03-09T06:00:00.000", :actual_cost => 3.89, :actual_consumption => 37.303},
  {:date => "2011-03-08T06:00:00.000", :actual_cost => 3.71, :actual_consumption => 35.679},
  {:date => "2011-03-07T06:00:00.000", :actual_cost => 3.77, :actual_consumption => 35.922},
  {:date => "2011-03-06T06:00:00.000", :actual_cost => 3.68, :actual_consumption => 35.211},
  {:date => "2011-03-05T06:00:00.000", :actual_cost => 3.66, :actual_consumption => 35.063},
  {:date => "2011-03-04T06:00:00.000", :actual_cost => 3.04, :actual_consumption => 38.01},
  {:date => "2011-03-03T06:00:00.000", :actual_cost => 3.15, :actual_consumption => 39.384},
  {:date => "2011-03-02T06:00:00.000", :actual_cost => 3.70, :actual_consumption => 35.557},
  {:date => "2011-03-01T06:00:00.000", :actual_cost => 3.64, :actual_consumption => 34.984}
]




end

