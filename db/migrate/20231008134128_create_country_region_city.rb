class CreateCountryRegionCity < ActiveRecord::Migration[7.0]
  def up
    unless table_exists?(:countries)
      create_table :countries do |t|
        t.string :name
        t.timestamps
      end
    end

    unless table_exists?(:regions)
      create_table :regions do |t|
        t.string :name
        t.integer :country_id

        t.timestamps
      end
    end

    unless table_exists?(:cities)
      create_table :cities do |t|
        t.string :name
        t.integer :region_id

        t.timestamps
      end
    end
  end

  def down
    execute(
      <<-SQL
        drop table if exists cities cascade;
        drop table if exists countries cascade;
        drop table if exists regions cascade;
      SQL
    )
  end
end
