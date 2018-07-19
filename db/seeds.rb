require 'csv'

# csv_text = File.read(Rails.root.join('lib', 'seeds', 'seoul.csv'))
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
# csv.each do |row|
#   t = District.new
#   t.state_id = 1

#   t.district_name = row['시군구명_한글']
  
#   t.save
# end




csv_text = File.read(Rails.root.join('lib', 'seeds', 'seoul_dong.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  d = District.new
  t = Road.new
  t.state_id = 1
  
  d = District.find_by_district_name(row['자치구'])
  t.district_id = d.id
  t.road_name = row['동']
  
  t.save
end