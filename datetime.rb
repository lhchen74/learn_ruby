# DateTime < Date standardc lib
# Time core lib
# The three classes include Comparable module

require 'date'

# create
date = Date.today
dt = DateTime.now
time = Time.now


# get
p date.year
p date.month
p date.wday
p date.yday
p date.prev_day
p date.next_day

p time.year
p time.month
p time.hour
p time.min
p time.sec


# manipulation
p Date.today + 1
p DateTime.now + 1
p Time.now + 1
p Date.today > Date.today.prev_day

p Time.singleton_class.instance_methods(false)  # [:at, :now, :utc, :gm, :local, :mktime]
require 'time'
p Time.singleton_class.instance_methods(false)  # [:iso8601, :parse, :xmlschema, :zone_offset, :rfc2822, :rfc822, :at, :httpdate, :now, :utc, :gm, :local, :mktime, :strptime]

p Date.parse('03/11/2020') # general European DateTime  #<Date: 2020-11-03 ((2459157j,0s,0n),+0s,2299161j)>
p DateTime.parse('03/11/2020') # general European DateTime
p Date.strptime('03/11/2020', '%m/%d/%Y') # #<Date: 2020-03-11 ((2458920j,0s,0n),+0s,2299161j)>

TRY_FORMATS = ['%d/%m/%Y', '%Y %m %d']
def try_to_parse(s)
    parsed = nil

    TRY_FORMATS.each do |format|
        begin
            parsed = Date.strptime(s, format)
        rescue ArgumentError
        end
    end

    parsed
end

p try_to_parse('03/11/2020')


p Time.now.to_s
p Time.now.strftime('%m/%d/%Y')

start_date = Date.new(2020, 11, 20)
end_date = Date.new(2020, 11, 25)

(start_date..end_date).each{|x| puts x}
start_date.upto(end_date).each{|x| puts x}
start_date.step(end_date, 2).each{|x| puts x}
