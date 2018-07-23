require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'nickname.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  n = Nickname.create(word: row['단어'])
  p n.id
end