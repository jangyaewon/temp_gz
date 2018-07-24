require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'woman.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
 
  r = Restaurant.new
  r =Restaurant.where(res_name: row['사용장소'], detail_addr: row['상세주소'])[0]
  
  if r.nil?
    r1 = Restaurant.new
    ro = Road.new
    ro = Road.find_by_road_name(row['road2'])
    p ro.id
    
    r1.g_name = row['사용기관']
    r1.res_name = row['사용장소']
    r1.detail_addr = row['상세주소']
    r1.food_type = row['종류']
    r1.state_id = 1
    r1.road_id = ro.id
    r1.district_id = ro.district_id
    r1.r_count = 1
    r1.latitude = row['Latitude']
    r1.longitude = row['Longitude']
    contents = row['contents']
    r1.save
    p row['road2']
  else
    r.r_count += 1 
    r.save
  end
  end