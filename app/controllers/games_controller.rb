require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { Array('A'..'Z').sample }.join(' ')
  end

  def score
    @score = 0
    @word = params[:word]
    @letters = params[:letters]
    english_word(@word)
  end

  private

  def english_word(word)
    attempt_word = word
    attempt_word = attempt_word.split('')
    grid_check = attempt_word.each do |letter|
      if attempt_word.count(letter) <= @letters.count(letter)
      end
    end
    byebug
    # Why does grid check return 'word' not true or false?
    attempt_word.join
    url = "https://wagon-dictionary.herokuapp.com/#{attempt_word}"
    string = open(url).read
    result = JSON.parse(string)
    if result['found']
      @score += 1
      @message = "You found a word! Your score = #{@score}"
    elsif result['found'] == false
      @message = "#{word} is not a word!"
    elsif grid_check == false
      @message = "You know #{attempt_word} is not in the grid ;)"
    end
  end
end
