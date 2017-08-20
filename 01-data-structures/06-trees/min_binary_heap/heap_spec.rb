include RSpec

require_relative 'min_binary_heap'

RSpec.describe MinBinaryHeap, type: Class do
  let (:root) { Node.new("The Matrix", 87) }

  let (:tree) { MinBinaryHeap.new(root) }
  let (:pacific_rim) { Node.new("Pacific Rim", 72) }
  let (:braveheart) { Node.new("Braveheart", 78) }
  let (:jedi) { Node.new("Star Wars: Return of the Jedi", 80) }
  let (:donnie) { Node.new("Donnie Darko", 85) }
  let (:inception) { Node.new("Inception", 86) }
  let (:district) { Node.new("District 9", 90) }
  let (:shawshank) { Node.new("The Shawshank Redemption", 91) }
  let (:martian) { Node.new("The Martian", 92) }
  let (:hope) { Node.new("Star Wars: A New Hope", 93) }
  let (:empire) { Node.new("Star Wars: The Empire Strikes Back", 94) }
  let (:mad_max_2) { Node.new("Mad Max 2: The Road Warrior", 98) }

  describe "#insert(data)" do
    # it "properly inserts a new node as a left child" do
    #   tree.insert(tree.root, pacific_rim)
    #   expect(tree.root.left.title).to eq "The Matrix"
    # end

    it "properly inserts a new node as a left-left child" do
      tree.insert(tree.root, martian)
      tree.insert(tree.root, district)
      tree.insert(tree.root, braveheart)
      expect(tree.root.left.left.title).to eq "The Martian"
    end

    # it "properly inserts a new node as a left-right child" do
    #   tree.insert(tree.root, martian)
    #   tree.insert(tree.root, district)
    #   tree.insert(tree.root, braveheart)
    #   tree.insert(tree.root, inseption)
    #   expect(tree.root.left.right.title).to eq "The Matrix"
    # end
    #
    # it "properly inserts a new node as a right child" do
    #   tree.insert(tree.root, martian)
    #   tree.insert(tree.root, district)
    #   expect(tree.root.right.title).to eq "District 9"
    # end
    #
    # it "properly inserts a new node as a right-left child" do
    #   tree.insert(tree.root, martian)
    #   tree.insert(tree.root, district)
    #   tree.insert(tree.root, braveheart)
    #   tree.insert(tree.root, inseption)
    #   tree.insert(tree.root, donnie)
    #   expect(tree.root.right.left.title).to eq "District 9"
    # end
    #
    # it "properly inserts a new node as a right-right child" do
    #   tree.insert(tree.root, martian)
    #   tree.insert(tree.root, district)
    #   tree.insert(tree.root, braveheart)
    #   tree.insert(tree.root, inseption)
    #   tree.insert(tree.root, donnie)
    #   tree.insert(tree.root, mad_max_2)
    #   expect(tree.root.right.right.title).to eq "Mad Max 2: The Road Warrior"
    # end
  end

end
