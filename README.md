:airplane: airline_reports_program :airplane:
===========
A small airline wants a simple program to be written that produces flight summary reports based on flight, route and passenger data. 

Technologies used
----
- Ruby
- Rspec
- Git

How to run it
----
```
git clone git@github.com:GBouffard/airline_reports_program.git
cd airline_reports_program
bundle install
irb
Dir["./lib/*"].each {|file| require file }
ruby report_maker.rb example1 output1
```

How to run tests
----
```
cd airline_reports_program
rspec
```
and this is what you should see
![](public/image_to_come.png)