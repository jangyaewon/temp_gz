require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'seoul_dong.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
   r = Road.new
   r1 = Road.where(state_id: 17, road_name: row['읍면동명'])[0]
   p row['읍면동명']
   
   if r1.nil?
    r.road_name = row['읍면동명']
    r.state_id = 17
    r.district_id = 250
    r.save
   end
end