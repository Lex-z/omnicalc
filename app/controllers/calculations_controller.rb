class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.delete(' ').length

    @word_count = @text.split(' ').length

    @occurrences = @text.split(' ').count(@special_word)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (@apr/100/12 * @principal) / (1 - (1+@apr/100/12)**-(@years*12))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = (@ending - @starting)/60
    @hours = (@ending - @starting)/60/60
    @days = (@ending - @starting)/60/60/24
    @weeks = (@ending - @starting)/60/60/24/7
    @years = (@ending - @starting)/60/60/24/7/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    @median =
    if @count%2 == 1
        @sorted_numbers[@count/2]
    else
        (@sorted_numbers[@count/2-1]+@sorted_numbers[@count/2])/2
    end

    @sum = @numbers.sum

    @mean = @sum/@count

    @variance = (@numbers.inject(0) { |variance, x| variance += (x - @mean) ** 2 })/(@count-1)

    @standard_deviation = @variance**0.5

    # https://gist.github.com/parksilk/4448602

    def mode(array)
      counter = Hash.new(0)
      array.each do |i|
        counter[i] += 1
    end

    mode_array = []

    counter.each do |k, v|
        if v == counter.values.max
          mode_array << k
      end
    end
    mode_array.sort
    end

    @mode = mode(@numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
