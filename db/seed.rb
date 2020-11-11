# Parse the CSV and seed the database here! Run 'ruby db/seed' to execute this code.
require "sqlite3"
require "csv"

db = SQLite3::Database.new ":memory:"

# Create a database
rows = db.execute <<-SQL
  create table users (
    id INTEGER PRIMARY KEY,
    year INTEGER,
    occupation TEXT,
    show TEXT,
    group TEXT
  );
SQL

CSV.parse(daily_show_guests.csv, headers: true) do |row|
  db.execute "insert into users values (?, ?)", row.fields
end

db.execute("select * from users")
