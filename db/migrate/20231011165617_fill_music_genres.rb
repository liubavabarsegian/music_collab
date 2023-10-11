class FillMusicGenres < ActiveRecord::Migration[7.0]
  def up
    execute(
      <<-SQL
      INSERT INTO music_genres (name, created_at, updated_at)
      VALUES
          ('Рок', NOW(), NOW()),
          ('Поп', NOW(), NOW()),
          ('Хип-хоп', NOW(), NOW()),
          ('Классическая', NOW(), NOW()),
          ('Джаз', NOW(), NOW()),
          ('Блюз', NOW(), NOW()),
          ('Регги', NOW(), NOW()),
          ('Кантри', NOW(), NOW()),
          ('Электроника', NOW(), NOW()),
          ('Метал', NOW(), NOW()),
          ('Латиноамериканская', NOW(), NOW()),
          ('Фанк', NOW(), NOW()),
          ('Рэп', NOW(), NOW()),
          ('Диско', NOW(), NOW()),
          ('Соул', NOW(), NOW()),
          ('Классический рок', NOW(), NOW()),
          ('Инди', NOW(), NOW()),
          ('Панк', NOW(), NOW()),
          ('R&B', NOW(), NOW()),
          ('Классическая музыка', NOW(), NOW());
      SQL
    )
  end

  def down
    execute(
      <<-SQL
        delete from music_genres;
      SQL
    )
  end
end
