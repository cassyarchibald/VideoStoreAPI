require "test_helper"

describe Movie do
  let(:scary) { movies(:scary) }
  let(:romantic) { movies(:romantic) }
  let(:funny) { movies(:funny) }

  describe "relations" do
    it "has customers through rentals" do
    end

  decribe "validations" do
    it "must be valid" do
      expect(scary).must_be :valid?
    end

    it "requires a title" do
    end 

    it "require"

has_many :customers, through: :rentals

scary:
  title: The Blue Door
  overview: The unexciting life of a boy will be permanently altered as a strange woman enters his life
  release_date: 1979-01-18
  inventory: 10

romantic:
  title: Women Of Destruction
  overview: But what if this strange woman is a con artist. Or what if everything told is completely true.
  release_date: 2006-10-01
  inventory: 1

funny:
  title: Robots Of Eternity
  overview: But what if this childhood friend is just a crazy person.
  release_date: 1948-03-31
  inventory: 9
