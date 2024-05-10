class Inventory
    attr_accessor :books
    
    def initialize
       @books=[]
       load_books
    end
  
    def load_books
        if File.exist?('Inventory.txt')
          File.foreach('Inventory.txt') do |line|
            isbn, title, author = line.chomp.split(', ')
            @books << { isbn: isbn, title: title, author: author }
          end
        end
      end
    def add_book(isbn, title, author)
      book = {isbn: isbn, title: title, author: author}
      @books.push(book)
    end


    def display_book()
        for book in @books
            puts "book{ISBN:#{book[:isbn]} ,title:#{book[:title]},author:#{book[:author]}}"
        end
        @books
    end
    
    def remove_book(isbn)
        for book in @books
            if(book[:isbn]==isbn)
                @books.delete(book)
            end
        end
      end
    
      def search_by_isbn(isbn)
        for book in @books
            if(book[:isbn]==isbn)
                puts "book{ISBN:#{book[:isbn]} ,title:#{book[:title]},author:#{book[:author]}}"
            end
        end
      end


      def search_by_title(title)
        for book in @books
            if(book[:title]==title)
                puts "book{ISBN:#{book[:isbn]} ,title:#{book[:title]},author:#{book[:author]}}"
            end
        end
      end

      def search_by_author(author)
        for book in @books
            if(book[:author]==author)
                puts "book{ISBN:#{book[:isbn]} ,title:#{book[:title]},author:#{book[:author]}}"
            end
        end
      end
      
end
 

 
def storeInFile(isbn,title,author)
    file = File.new("Inventory.txt", "a")
    file.puts({isbn: isbn, title: title, author: author})
    file.close

end
op = 0

inventory = Inventory.new()

while op != 7
  puts('Select Options:')
  puts('1-List Books')
  puts('2-Add new book')
  puts('3-Remove book by ISBN')
  puts('4-Search book by ISBN')
  puts('5-Search book by title')
  puts('6-Search book by author')
  puts('7-Exit')
  print('Enter your choice: ')
  
  op = gets.to_i

  case op
  when 1
    inventory.display_book()
  when 2
    puts('Enter ISBN:')
    isbn = gets.chomp
    puts('Enter title:')
    title = gets.chomp
    puts('Enter author:')
    author = gets.chomp
    inventory.add_book(isbn, title, author)
    storeInFile(isbn,title,author)
  when 3
    puts('Enter ISBN to remove:')
    isbn = gets.chomp
    inventory.remove_book(isbn)
   when 4
    puts('Enter ISBN to Search:')
    isbn = gets.chomp
    inventory.search_by_isbn(isbn)
   when 5
        puts('Enter title to Search:')
        title = gets.chomp
        inventory.search_by_title(title)
   when 6
        puts('Enter author to Search:')
        author = gets.chomp
        inventory.search_by_author(author)
  when 7
    puts('Exiting...')
  else
    puts('Invalid option. Please try again.')
  end
end


