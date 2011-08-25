=begin
index:Ej

= Data/Page: Help when paging through sets of results

Last Modified: 2005-05-22 00:28:04

--

When searching through large amounts of data, it is often the case
that a result set is returned that is larger than we want to display
on one page. This results in wanting to page through various pages of
data. The maths behind this is unfortunately fiddly, hence this
module.

The main concept is that you pass in the number of total entries, the
number of entries per page, and the current page number. You can then
call methods to find out how many pages of information there are, and
what number the first and last entries on the current page really are.

For example, say we wished to page through the integers from 1 to 100
with 20 entries per page. The first page would consist of 1-20, the
second page from 21-40, the third page from 41-60, the fourth page
from 61-80 and the fifth page from 81-100. This module would help you
work this out.

== Examples

  require "datapage"

  page = Data::Page.new()
  page.total_entries(total_entries)
  page.entries_per_page(entries_per_page)
  page.current_page(current_page)

  puts "         First page: #{page.first_page}"
  puts "          Last page: #{page.last_page}"
  puts "First entry on page: #{page.first}"
  puts " Last entry on page: #{page.last}"

== API

--- Data::Page#new ()
    This is the constructor, which takes no arguments.
        page = Data::Page.new()

--- Data::Page#total_entries
    This method get or sets the total number of entries:
       puts "Entries: #{page.total_entries}"

--- Data::Page#entries_per_page
    This method get or sets the total number of entries
    per page (which defaults to 10):
       puts "Per page: #{page.entries_per_page}"

--- Data::Page#current_page
    This method gets or sets the current page number
    (which defaults to 1):
       puts "Page: #{page.current_page}"

--- Data::Page#entries_on_this_page
    This methods returns the number of entries on the current page:
       puts "There are #{page.entries_on_this_page} entries displayed"

--- Data::Page#first_page
    This method returns the first page. This is put in for reasons of
    symmetry with last_page, as it always returns 1:
       puts "Pages range from: #{page.first_page}"

--- Data::Page#last_page
    This method returns the total number of pages of information:
       puts "Pages range to: #{page.last_page}"

--- Data::Page#first
    This method returns the number of the first entry on the current page:
       puts "Showing entries from: #{page.first}"

--- Data::Page#last
    This method returns the number of the last entry on the current page:
       puts "Showing entries to: #{page.last}"

--- Data::Page#previous_page
    This method returns the previous page number, if one exists. Otherwise
    it returns nil:
       puts "Previous page number: #{page.previous_page}" if page.previous_page

--- Data::Page#next_page
    This method returns the next page number, if one exists. Otherwise
    it returns nil:
       puts "Next page number: #{page.next_page}" if page.next_page

--- Data::Page#splice( array )
    This method takes in a array, and returns only the values which are
    on the current page:
       visible_holidays = page.splice(holidays);

--- Data::Page#skipped
    This method is useful paging through data in a database using SQL
    LIMIT clauses. It is simply page.first - 1:

--- Data::Page#change_entries_per_page
    This method changes the number of entries per page and the
    current page number such that the *first* item on the current
    page will be present on the new page:
        page.total_entries(50);
        page.entries_per_page(20);
        page.current_page(3);
        puts page->first; # 41
        page.change_entries_per_page(30);
        puts page.current_page; # 2 - the page that item 41 will show in

== Notes

It has been said before that this code is "too simple" for distribution, but I
must disagree. I have seen people write this kind of code over and
over again and they always get it wrong. Perhaps now they will spend
more time getting the rest of their code right...

--

- ((<Leon Brocard|URL:http://www.astray.com/>)) -
=end
