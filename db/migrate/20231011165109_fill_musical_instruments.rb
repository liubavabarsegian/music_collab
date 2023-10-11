class FillMusicalInstruments < ActiveRecord::Migration[7.0]
  def up
    execute(
      <<-SQL
        INSERT INTO musical_instruments (name, created_at, updated_at)
        VALUES
          ('Гитара', NOW(), NOW()),
          ('Фортепиано', NOW(), NOW()),
          ('Скрипка', NOW(), NOW()),
          ('Флейта', NOW(), NOW()),
          ('Труба', NOW(), NOW()),
          ('Ударные барабаны', NOW(), NOW()),
          ('Аккордеон', NOW(), NOW()),
          ('Тромбон', NOW(), NOW()),
          ('Гармоника', NOW(), NOW()),
          ('Контрабас', NOW(), NOW()),
          ('Виолончель', NOW(), NOW()),
          ('Кларнет', NOW(), NOW()),
          ('Саксофон', NOW(), NOW()),
          ('Орган', NOW(), NOW()),
          ('Балалайка', NOW(), NOW()),
          ('Электрогитара', NOW(), NOW()),
          ('Барабаны', NOW(), NOW()),
          ('Арфа', NOW(), NOW()),
          ('Фагот', NOW(), NOW()),
          ('Трубадур', NOW(), NOW()),
          ('Мандолина', NOW(), NOW()),
          ('Банджо', NOW(), NOW()),
          ('Рояль', NOW(), NOW()),
          ('Виола', NOW(), NOW()),
          ('Туба', NOW(), NOW()),
          ('Электронный синтезатор', NOW(), NOW()),
          ('Валторна', NOW(), NOW()),
          ('Гусли', NOW(), NOW()),
          ('Флейта-пикколо', NOW(), NOW()),
          ('Тамбурин', NOW(), NOW());
      SQL
    )
  end

  def down
    execute(
      <<-SQL
        delete from musical_instruments;
      SQL
    )
  end
end
