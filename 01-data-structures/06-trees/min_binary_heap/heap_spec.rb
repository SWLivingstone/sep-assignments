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
    it "properly inserts a new node as a left child" do
      tree.insert(pacific_rim)
      expect(tree.root.left.title).to eq "The Matrix"
    end

    it "properly inserts a new node as a left-left child" do
      tree.insert(martian)
      tree.insert(district)
      tree.insert(braveheart)
      expect(tree.root.left.left.title).to eq "The Martian"
    end

    it "properly inserts a new node as a left-right child" do
      tree.insert(martian)
      tree.insert(district)
      tree.insert(braveheart)
      tree.insert(inception)
      expect(tree.root.left.right.title).to eq "The Matrix"
    end

    it "properly inserts a new node as a right child" do
      tree.insert(martian)
      tree.insert(district)
      expect(tree.root.right.title).to eq "District 9"
    end

    it "properly inserts a new node as a right-left child" do
      tree.insert(martian)
      tree.insert(district)
      tree.insert(braveheart)
      tree.insert(inception)
      tree.insert(donnie)
      expect(tree.root.right.left.title).to eq "District 9"
    end

    it "properly inserts a new node as a right-right child" do
      tree.insert( martian)
      tree.insert( district)
      tree.insert( braveheart)
      tree.insert( inception)
      tree.insert( donnie)
      tree.insert( mad_max_2)
      expect(tree.root.right.right.title).to eq "Mad Max 2: The Road Warrior"
    end
  end

  describe "#find(data)" do
    it "properly finds a left child" do
      tree.insert( pacific_rim)
      expect(tree.find("The Matrix").title).to eq "The Matrix"
    end

    it "properly finds a left-left child" do
      tree.insert( martian)
      tree.insert( district)
      tree.insert( braveheart)
      expect(tree.find("The Martian").title).to eq "The Martian"
    end

    it "properly finds a left-right child" do
      tree.insert( martian)
      tree.insert( district)
      tree.insert( braveheart)
      tree.insert( inception)
      expect(tree.find("The Matrix").title).to eq "The Matrix"
    end

    it "properly finds a right child" do
      tree.insert( martian)
      tree.insert( district)
      expect(tree.find("District 9").title).to eq "District 9"
    end

    it "properly finds a right-left child" do
      tree.insert( martian)
      tree.insert( district)
      tree.insert( braveheart)
      tree.insert( inception)
      tree.insert( donnie)
      expect(tree.find("District 9").title).to eq "District 9"
    end

    it "properly finds a right-right child" do
      tree.insert( martian)
      tree.insert( district)
      tree.insert( braveheart)
      tree.insert( inception)
      tree.insert( donnie)
      tree.insert( mad_max_2)
      expect(tree.find("Mad Max 2: The Road Warrior").title).to eq "Mad Max 2: The Road Warrior"
    end
  end

  describe "#delete(data)" do
    it "properly deletes root.left" do
      tree.insert( martian)
      tree.insert( district)
      tree.insert( braveheart)
      tree.insert( inception)
      tree.insert( donnie)
      tree.insert( mad_max_2)
      tree.delete(tree.root.left.title)
      expect(tree.find("Inception")).to be_nil
      expect(tree.root.left.rating).to eq 87
    end

    it "properly deletes root.left.left" do
      tree.insert( martian)
      tree.insert( district)
      tree.insert( braveheart)
      tree.insert( inception)
      tree.insert( donnie)
      tree.insert( mad_max_2)
      tree.delete(root.left.left.title)
      expect(tree.find("The Martian")).to be_nil
      expect(tree.root.left.left.rating).to eq 98
    end

    it "properly deletes root.left.right" do
      tree.insert( martian)
      tree.insert( district)
      tree.insert( braveheart)
      tree.insert( inception)
      tree.insert( donnie)
      tree.insert( mad_max_2)
      tree.delete(root.left.right.title)
      expect(tree.find("The Matrix")).to be_nil
      expect(tree.root.left.right.rating).to eq 98
    end

    it "properly deletes root.right" do
      tree.insert( martian)
      tree.insert( district)
      tree.insert( braveheart)
      tree.insert( inception)
      tree.insert( donnie)
      tree.insert( mad_max_2)
      tree.delete(root.right.title)
      expect(tree.find("Donnie Darko")).to be_nil
      expect(tree.root.right.rating).to eq 90
    end

    it "properly deletes root.right.left" do
      tree.insert( martian)
      tree.insert( district)
      tree.insert( braveheart)
      tree.insert( inception)
      tree.insert( donnie)
      tree.insert( mad_max_2)
      tree.delete(root.right.left.title)
      expect(tree.find("District 9")).to be_nil
      expect(tree.root.right.left.rating).to eq 98
    end

    it "properly finds a right-right child" do
      tree.insert( martian)
      tree.insert( district)
      tree.insert( braveheart)
      tree.insert( inception)
      tree.insert( donnie)
      tree.insert( mad_max_2)
      tree.delete(root.right.right.title)
      expect(tree.find("Mad Max 2: The Road Warrior")).to be_nil
      expect(root.right.right).to eq nil
    end
  end

  describe "#printf" do
     specify {
       expected_output = "\"Pacific Rim: 72\\nBraveheart: 78\\nStar Wars: Return of the Jedi: 80\\nThe Matrix: 87\\nDistrict 9: 90\\nStar Wars: The Empire Strikes Back: 94\\nInception: 86\\nStar Wars: A New Hope: 93\\nThe Shawshank Redemption: 91\\nThe Martian: 92\\nMad Max 2: The Road Warrior: 98\\n\"\n"
       tree.insert( hope)
       tree.insert( empire)
       tree.insert( jedi)
       tree.insert( martian)
       tree.insert( pacific_rim)
       tree.insert( inception)
       tree.insert( braveheart)
       tree.insert( shawshank)
       tree.insert( district)
       tree.insert( mad_max_2)
       expect { tree.printf }.to output(expected_output).to_stdout
     }

     specify {
       expected_output = "\"Pacific Rim: 72\\nStar Wars: Return of the Jedi: 80\\nBraveheart: 78\\nThe Matrix: 87\\nThe Shawshank Redemption: 91\\nDistrict 9: 90\\nInception: 86\\nMad Max 2: The Road Warrior: 98\\nThe Martian: 92\\nStar Wars: The Empire Strikes Back: 94\\nStar Wars: A New Hope: 93\\n\"\n"
       tree.insert( mad_max_2)
       tree.insert( district)
       tree.insert( shawshank)
       tree.insert( braveheart)
       tree.insert( inception)
       tree.insert( pacific_rim)
       tree.insert( martian)
       tree.insert( jedi)
       tree.insert( empire)
       tree.insert( hope)
       expect { tree.printf }.to output(expected_output).to_stdout
     }
  end

end
