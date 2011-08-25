require "datapage"
require "test/unit"

class TestSimpleNumber < Test::Unit::TestCase
 
  def test_simple_1
    text = "# Initial test
50 10 1    1 5 1 10 undef 1 2 0,1,2,3,4,5,6,7,8,9            10    15 1
50 10 2    1 5 11 20 1 2 3 10,11,12,13,14,15,16,17,18,19     10    15 1
50 10 3    1 5 21 30 2 3 4 20,21,22,23,24,25,26,27,28,29     10    15 2
50 10 4    1 5 31 40 3 4 5 30,31,32,33,34,35,36,37,38,39     10    15 3
50 10 5    1 5 41 50 4 5 undef 40,41,42,43,44,45,46,47,48,49 10    15 3

# Under 10
1 10 1    1 1 1 1 undef 1 undef 0                     1    15 1
2 10 1    1 1 1 2 undef 1 undef 0,1                   2    15 1
3 10 1    1 1 1 3 undef 1 undef 0,1,2                 3    15 1
4 10 1    1 1 1 4 undef 1 undef 0,1,2,3               4    15 1
5 10 1    1 1 1 5 undef 1 undef 0,1,2,3,4             5    15 1
6 10 1    1 1 1 6 undef 1 undef 0,1,2,3,4,5           6    15 1
7 10 1    1 1 1 7 undef 1 undef 0,1,2,3,4,5,6         7    15 1
8 10 1    1 1 1 8 undef 1 undef 0,1,2,3,4,5,6,7       8    15 1
9 10 1    1 1 1 9 undef 1 undef 0,1,2,3,4,5,6,7,8     9    15 1
10 10 1   1 1 1 10 undef 1 undef 0,1,2,3,4,5,6,7,8,9  10   15 1

# Over 10
11 10 1    1 2 1 10 undef 1 2 0,1,2,3,4,5,6,7,8,9     10   10 1
11 10 2    1 2 11 11 1 2 undef 10                     1    10 2
12 10 1    1 2 1 10 undef 1 2 0,1,2,3,4,5,6,7,8,9     10   10 1
12 10 2    1 2 11 12 1 2 undef 10,11                  2    10 2
13 10 1    1 2 1 10 undef 1 2 0,1,2,3,4,5,6,7,8,9     10   10 1
13 10 2    1 2 11 13 1 2 undef 10,11,12               3    10 2

# Under 20
19 10 1    1 2 1 10 undef 1 2 0,1,2,3,4,5,6,7,8,9            10   4 1
19 10 2    1 2 11 19 1 2 undef 10,11,12,13,14,15,16,17,18    9    4 3
20 10 1    1 2 1 10 undef 1 2 0,1,2,3,4,5,6,7,8,9            10   4 1
20 10 2    1 2 11 20 1 2 undef 10,11,12,13,14,15,16,17,18,19 10   4 3

# Over 20
21 10 1    1 3 1 10 undef 1 2 0,1,2,3,4,5,6,7,8,9        10   19 1
21 10 2    1 3 11 20 1 2 3 10,11,12,13,14,15,16,17,18,19 10   19 1
21 10 3    1 3 21 21 2 3 undef 20                        1    19 2
22 10 1    1 3 1 10 undef 1 2 0,1,2,3,4,5,6,7,8,9        10   19 1
22 10 2    1 3 11 20 1 2 3 10,11,12,13,14,15,16,17,18,19 10   19 1
22 10 3    1 3 21 22 2 3 undef 20,21                     2    19 2
23 10 1    1 3 1 10 undef 1 2 0,1,2,3,4,5,6,7,8,9        10   19 1
23 10 2    1 3 11 20 1 2 3 10,11,12,13,14,15,16,17,18,19 10   19 1
23 10 3    1 3 21 23 2 3 undef 20,21,22                  3    19 2

# Zero test
0 10 1    1 1 0 0 undef 1 undef '' 0    5 1
"
    lines = text.split("\n");
    lines.each do |line|
      next if line.length == 0
      if line.match(/^# ?(.+)/)
        name = $1
        puts "name is #{name}"
        next
      end
      puts "[#{line}]"
      vals = line.split(/\s+/).collect! {|x|
        if x.match(/^undef$/)
          nil
        elsif x.match(/^''$/)
          ''
        elsif x.match(/^\d+$/)
          x.to_i
        else
          x
        end
      }
      puts vals.inspect
      oldpage = Data::Page.new(vals[0].to_i, vals[1].to_i, vals[2].to_i)
      self._check(oldpage, name, vals);
      newpage = Data::Page.new()
      newpage.total_entries(vals[0].to_i)
      newpage.entries_per_page(vals[1].to_i)
      newpage.current_page(vals[2].to_i)
      self._check(newpage, name, vals);
    end
    page = Data::Page.new(100, 10, 1)
    assert_equal(page.total_entries, 100)
    assert_equal(page.entries_per_page, 10)
    assert_equal(page.current_page, 1)
    assert_equal(page.first_page, 1)
    assert_equal(page.last_page, 10)
    assert_equal(page.first, 1)
    assert_equal(page.last, 10)
    assert_equal(page.previous_page, nil)
    assert_equal(page.next_page, 2)
    assert_equal(page.splice([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]), [1,2,3,4,5,6,7,8,9,10])
    assert_equal(page.skipped, 0)
    assert_equal(page.entries_on_this_page, 10)
  end
  def _check(page, name, vals)
    puts "check #{page.total_entries} total_entries, #{page.entries_per_page} entries_per_page, #{page.current_page} current_page"
    assert_instance_of(Data::Page, page)
    assert_equal(page.first_page, vals[3])
    assert_equal(page.last_page, vals[4])
    assert_equal(page.first, vals[5])
    assert_equal(page.last, vals[6])
    assert_equal(page.previous_page, vals[7])
    assert_equal(page.current_page, vals[8])
    assert_equal(page.next_page, vals[9])
    
    integers = (0..vals[0]-1).to_a
    integers = page.splice(integers)
    integers = integers.join(',')
    assert_equal(integers, vals[10].to_s)

    assert_equal( page.entries_on_this_page, vals[11])

    skipped = vals[5] - 1
    skipped = 0 if skipped < 0
    assert_equal(page.skipped, skipped );
    page.change_entries_per_page( vals[12] );
    assert_equal( page.current_page, vals[13] );
  end
end


