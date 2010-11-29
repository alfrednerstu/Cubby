class Article < ActiveRecord::Base
  before_create :readability, :permalink_slug
  before_update :readability, :permalink_slug
  
  has_many :readinglists, :dependent => :destroy
  has_many :users, :through => :readinglists
  
  def readability
    require 'readability'
    require 'open-uri'
    source = open(self.url).read
    self.content = Readability::Document.new(source).content
  end
  
  def permalink_slug
    #make permalink slug
  end
      
  attr_accessible :title, :url, :content
end
