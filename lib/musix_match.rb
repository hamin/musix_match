class MusixMatch
  require 'hash_symbolize_keys'
  require 'httparty'
  include HTTParty

  base_uri "http://api.musixmatch.com/ws/1.1"
  
  attr_reader :api_key
  
  def initialize(api_key,opts={})
    @api_key = api_key
    MusixMatch.base_uri opts[:base_url] if opts[:base_url] 
  end

  
  def track_search(opts={})
    MusixMatch.get("/track.search?apikey=#{@api_key}", :query => {
                                                              :q => opts[:q],
                                                              :q_track => opts[:q_track],
                                                              :q_artist => opts[:q_artist],
                                                              :q_track_artist => opts[:q_track_artist],
                                                              :q_lyrics => opts[:q_lyrics],
                                                              :format => opts[:format], 
                                                              :page => opts[:page],
                                                              :page_size => opts[:page_size],
                                                              :f_has_lyrics => opts[:f_has_lyrics],
                                                              :f_artist_id => opts[:f_artist_id],
                                                              :f_artist_mbid => opts[:f_artist_mbid],
                                                              :quorum_factor => opts[:quorum_factor]
                                                            }).recursive_symbolize_keys!
  end
  
  def track_lyrics_get(opts={})
    MusixMatch.get("/track.lyrics.get?apikey=#{@api_key}", :query => { :format => opts[:format], :track_id => opts[:track_id] }).recursive_symbolize_keys!
  end
  
end