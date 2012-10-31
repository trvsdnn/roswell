class Tag
  def self.all
  end

  def self.map
    <<-MAP
    function() {
      emit(this._id, { tags: this.tags });
    };
    MAP
  end

  def self.reduce
    <<-REDUCE
    function(key, values) {
      var tags = [];
      values.forEach(function(doc) {
        tags.concat(doc.tags);
      });
      return { tags: tags };
    };
    REDUCE
  end
end
