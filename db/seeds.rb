require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'woman.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
   r = Restaurant.where(res_name: row['사용장소'], detail_addr: row['상세주소'])[0]
   p r.id
   Restaurant.update(r.id, :contents => row['contents'])

   p r.contents
end
