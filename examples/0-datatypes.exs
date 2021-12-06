atom = :atom
boolean = true
bits = <<0x00, 0xFF, 0x42>>
<<n::16, rest>> = <<0xFF, 0x00, 0x42>>
string = "I'm a string"
fancy_string = <<72, 101, 108, 108, 111>>
integer = 42
float = 3.1415
tuple = {"one", 2, :three}
list = ["one", 2, :three]
["head" | ["one", 2, :three]]
map = %{:name "Frodo", :race :hobbit, age: 40}
