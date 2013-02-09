# Add a declarative step here for populating the DB with movies.
 
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end
 
# Make sure that one string (regexp) occurs before or after another one
#   on the same page
 
Then /^I should see "(.*?)" before "(.*?)"$/ do |arg1, arg2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
end
 
# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"
 
Given /I check the movies only of rating 'PG' or 'R'/ do
  check('ratings_PG')
  check('ratings_R')
  uncheck('ratings_PG-13')
  uncheck('ratings_G')
end
 
When /I click on submit/ do
  click_button('ratings_submit')
end
 
Then /I should only see 'PG' or 'R' rated movies/ do
 page.body.should match(/<td>R<\/td>/)
 page.body.should match(/<td>PG<\/td>/)
end
 
Then /I should not see movies rated 'PG-13' or 'G'/ do
  page.body.should_not match(/<td>PG-13<\/td>/)
  page.body.should_not match(/<td>G<\/td>/)
end
 
When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
        ratings = rating_list.split(", ")
        ratings.each do |rating|
                if uncheck then
                        uncheck("ratings_#{rating}")
                else
                        check("ratings_#{rating}")
                end
        end
end
 
Then /^I should see all of the movies$/ do
        assert all("table#movies tbody tr").count == 10
end

Then /^I should not see any movies$/ do
  assert all("table#movies tbody tr").count == 0
end

Then /^the director of "(.*?)" should be "(.*?)"$/ do |movie_title, the_director|
	movie = Movie.find_by_title movie_title
        movie.director.should == the_director
end
