describe Graph do
  let(:edges) { [['a','d'],['b','e'],['c','b'],['f','c']] }
  let(:vertices) { ['a','b','c','d','e','f'] }
  let(:graph) { Graph.new(vertices, edges) }

  describe '#edges' do
    subject { graph.edges }

    context 'on instantiation' do
      it { should == [['a','d'],['b','e'],['c','b'],['f','c']] }
    end

    context 'after deleting a vertex' do
      before do
        graph.delete_vertex('c')
      end
      it { should == [['a','d'],['b','e']] }
    end
  end

  describe '#vertices' do
    subject { graph.vertices }

    context 'on instantiation' do
      it { should == ['a','b','c','d','e','f'] }
    end

    context 'after deleting a vertex' do
      before do
        graph.delete_vertex('c')
      end
      it { should == ['a','b','d','e','f'] }
    end
  end

  describe '#non_terminal_vertices' do
    subject { graph.non_terminal_vertices }

    context 'on instantiation' do
      it { should == ['a','f'] }
    end

    context 'after deleting some vertices' do
      before do
        graph.delete_vertex('a')
        graph.delete_vertex('f')
        graph.delete_vertex('d')
      end
      it { should == ['c'] }
    end
  end
end
