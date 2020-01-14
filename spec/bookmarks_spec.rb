require 'bookmarks'

describe Bookmark do

  let(:con){double :con, :exec => [{'url' => 'test'}]}

  describe '.all' do
    it 'returns all bookmarks' do
      Bookmark.add_connection(con)
      expect(Bookmark.all).to eq(['test'])
    end
    it 'rescues error' do
      allow(con).to receive(:exec).and_raise('Error')
      Bookmark.add_connection(con)

      expect(STDOUT).to receive(:puts).with('Error')
      Bookmark.all
    end
  end
end
