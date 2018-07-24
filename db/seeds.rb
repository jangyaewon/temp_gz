require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'seoul_dong.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
   s = State.new
   s1 = State.where(state_name: row['시도명'])[0]
   p row['시도명']
   
   if s1.nil?
    s.state_name = row['시도명']
    s.save
   end
end