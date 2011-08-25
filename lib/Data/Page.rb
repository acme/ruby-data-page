class Data::Page
  attr_reader :total_entries, :entries_per_page, :current_page
  def initialize(total_entries=0, entries_per_page=10, current_page=1)
    @total_entries, @entries_per_page, @current_page = total_entries, entries_per_page, current_page
  end
  def total_entries(*total_entries)
    @total_entries = total_entries[0] if total_entries[0]
    return @total_entries
  end
  def entries_per_page(*entries_per_page)
    @entries_per_page = entries_per_page[0] if entries_per_page[0]
    return @entries_per_page
  end
  def current_page(*current_page)
    @current_page = current_page[0] if current_page[0]
    return @current_page
  end
  def first_page
    return 1
  end
  def last_page
    pages = @total_entries.to_f / @entries_per_page.to_f
    if pages == pages.floor
        last_page = pages
    else
        last_page = 1 + pages.floor
    end
    if last_page < 1
        last_page = 1
    end
    return last_page
  end
  def first
    if @total_entries == 0
        return 0
    else
        return ( ( @current_page - 1 ) * @entries_per_page ) + 1
    end
  end
  def last
    if @current_page == self.last_page
        return @total_entries
    else
        return @current_page * @entries_per_page
    end
  end
  def previous_page
    if @current_page > 1
        return @current_page - 1
    else
        return nil
    end
  end
  def next_page
    if @current_page < self.last_page
        return @current_page + 1
    else
        return nil
    end
  end
  def splice(array)
    if array.length > self.last
        top = self.last
    else
        top = array.length
    end
    if top == 0
        return []
    end
    return array.slice(self.first-1, self.last - self.first + 1)
  end
  def skipped
    skipped = self.first - 1
    if skipped < 0
        return 0
    else
        return skipped
    end
  end
  def entries_on_this_page
    if @total_entries == 0
        return 0
    else
        return self.last - self.first + 1
    end
  end
  def change_entries_per_page(new_epp)
    new_page = 1 + (self.first / new_epp)
    self.entries_per_page(new_epp)
    self.current_page(new_page)
  end
end
