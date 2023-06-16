In Ruby, a singleton is a class that can only have one instance. The idea of the singleton pattern is that you want a class with only one instance. Here’s how: You make the new method private; You define a class method named instance that returns the unique instance for the class; Because this is a popular design pattern, the Ruby standard library comes with a Singleton module you can include in any class¹.

Here's an example of how to use the Singleton module in Ruby:

```ruby
require 'singleton'

class Shop
  include Singleton
end
```

Now if you try to create a Shop object with `Shop.new` you’ll see this: `Shop.new # NoMethodError: private method 'new' called for Shop:Class`. And if you want to get the one & only Shop object you can use the instance method: `Shop.instance.object_id  # 5659218  Shop.instance.object_id  # 5659218`. You can tell it’s always the same object because the object_id never changes¹.


Source: Conversation with Bing, 6/16/2023
(1) How To Use The Singleton Pattern In Ruby (And Why You ... - RubyGuides. https://www.rubyguides.com/2018/05/singleton-pattern-in-ruby/.
(2) Ruby - Singleton Methods - GeeksforGeeks. https://www.geeksforgeeks.org/ruby-singleton-methods/.
(3) Explaining Ruby's Singleton Class (Eigenclass) to confused beginners. https://dev.to/samuelfaure/explaining-ruby-s-singleton-class-eigenclass-to-confused-beginners-cep.

## Thread Sage Singleton



