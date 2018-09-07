class CreateCreateGithubRepos < ActiveRecord::Migration
  def change
    create_table :create_github_repos do |t|

      t.timestamps null: false
    end
  end
end
