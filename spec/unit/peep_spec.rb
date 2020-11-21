require 'Peep'
require 'date'
require 'user'

describe Peep do
  it "initializes with id, posting time, body & author" do
    post = Peep.new(id: 1, time: DateTime.now, body: "Hello World", author: "partario")
    expect(post.id).to eq(1)
    expect(post.time.day).to eq(DateTime.now.day)
    expect(post.body).to eq("Hello World")
    expect(post.author).to eq("partario")
  end

  describe ".create" do
    it "adds a Peep to the database, returning a Peep object" do
      user = User.create(username: "partario", email: "test@email.com", password: "1234")
      example_peep = Peep.create(body: "Hello World", user_id: user.id)
      expect(example_peep.body).to eq("Hello World")
      expect(example_peep.time.day).to eq(DateTime.now.day)
    end

    it "ensures peep objects created return the name of the author" do
      user = User.create(username: "partario", email: "test@email.com", password: "1234")
      example_peep = Peep.create(body: "Hello World", user_id: user.id)
      expect(example_peep.author).to eq(user.username)
    end
  end

  describe ".find" do
    it "returns a peep object with the specified ID" do
      user = User.create(username: "partario", email: "test@email.com", password: "1234")
      example_peep = Peep.create(body: "Hello World", user_id: user.id)
      find_result = Peep.find(example_peep.id)
      expect(find_result.id).to eq(example_peep.id)
      expect(find_result.body).to eq(example_peep.body)
    end
  end

  describe ".all" do
    it "returns a list of one peep when there is one entry" do
      user = User.create(username: "partario", email: "test@email.com", password: "1234")
      example_peep = Peep.create(body: "Hello World", user_id: user.id)
      all_peeps = Peep.all
      expect(all_peeps.first.id).to eq(example_peep.id)
      expect(all_peeps.first.body).to eq(example_peep.body)
    end

    it "returns multiple peeps in list with newest first" do
      user = User.create(username: "partario", email: "test@email.com", password: "1234")
      old_peep = Peep.create(body: "Hello World", user_id: user.id)
      new_peep = Peep.create(body: "Hello World", user_id: user.id)
      all_peeps = Peep.all
      expect(all_peeps.first.id).to eq(old_peep.id)
      expect(all_peeps.last.id).to eq(new_peep.id)
    end
  end
end