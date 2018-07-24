require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'seoul_dong.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
   d = District.new
   s1 = State.where(state_name: row['시도명'])[0]
   d1 = District.where(state_id: s1.id, district_name: row['시군구명'])[0]
   p row['시군구명']
   
   if d1.nil?
    d.district_name = row['시군구명']
    d.state_id = s1.id
    d.save
   end
end