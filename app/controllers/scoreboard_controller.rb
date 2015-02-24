class ScoreboardController < ApplicationController
  def table
  end

  def rows
    p parse_params(params.require('filters'))

    @coders = Datavis.get_stats :coder,
      ['commits', 'additions', 'deletions', 'claimed'],
      parse_params(params.require('filters').to_hash)
    @coders.sort_by! {|c| Coder::score(c)}.reverse!
    render partial: 'rows'
  end

  private
  def parse_params hash
    hash.each do |key, value|
      if value.is_a? Hash
        hash[key] = parse_param value
      end
    end
  end

  def parse_param hash
    ParamConverters.each do |keys, block|
      if hash.keys == keys
        return block.yield(*keys.map {|k| hash[k]})
      end
    end
    hash
  end

  ParamConverters = {
    ['timeframe_begin', 'timeframe_end'] => proc do |b, e| 
      Range.new DateTime.parse(b), DateTime.parse(e)
    end
  }

end
