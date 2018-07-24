require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'seoul_dong.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
   r = Road.new
   s1 = State.where(state_name: row['시도명'])[0]
   d1 = District.where(state_id: s1.id, district_name: row['시군구명'])[0]
   r1 = Road.where(state_id: s1.id, district_id: d1.id, road_name: row['읍면동명'])[0]
   p row['읍면동명']
   
   if r1.nil?
    r.road_name = row['읍면동명']
    r.state_id = s1.id
    r.district_id = d1.id
    r.save
   end
end