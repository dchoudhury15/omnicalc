class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================
    special_word_string=@special_word.gsub(" ","").downcase

    text_edit=@text.gsub("\n"," ").gsub("\r","").gsub("\t","")

    @character_count_with_spaces = text_edit.length

    @character_count_without_spaces = text_edit.gsub(" ", "").length

    @word_count = text_edit.split.length

    @occurrences = @text.gsub(/[^a-z0-9 ]/i,"").downcase.split.count special_word_string


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f
    monthly_apr=@apr/12/100
    period=@years*12


    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = @principal*((((1+monthly_apr)**period))*monthly_apr)/((1+monthly_apr)**period-1)

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
    time_elapsed=(@ending-@starting).abs

    @seconds = time_elapsed
    @minutes = time_elapsed/60
    @hours = time_elapsed/60/60
    @days = time_elapsed/60/60/24
    @weeks = time_elapsed/60/60/24/7
    @years = time_elapsed/60/60/24/7/52

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
    # ============================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max-@numbers.min

    if @count % 2 != 0
      index_median=(@sorted_numbers.length + 1) / 2.0
      median=@sorted_numbers[index_median-1]
    else
      index_median=(@sorted_numbers.length) / 2.0
      median=((@sorted_numbers[index_median-1]+@sorted_numbers[index_median]) / 2.0)
      # index_median=((@numbers.length/2.0) + ((@numbers.length + 2)/2.0) / 2.0)
    end

    @median =median

    @sum = @numbers.inject(0, :+)

    @mean = @sum/@count

    intermediate=@numbers.map { |i| i - @mean }
    intermediate2=intermediate.map { |e| e**2  }

    @variance = intermediate2.inject(0,:+)/@count

    @standard_deviation = @variance**(0.5)
    # counts=Hash.new(0)
    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    # @numbers.each do |nummm|
    #   nummm +=1
    # end

    @mode = @numbers.max_by { |v| freq[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
