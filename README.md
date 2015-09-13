:airplane: airline_reports_program :airplane:
===========
A small airline wants a simple program to be written that produces flight summary reports based on flight, route and passenger data. 

Technologies used
----
- Ruby
- Rspec
- Git

How to set it up
----
```
git clone git@github.com:GBouffard/airline_reports_program.git
cd airline_reports_program
bundle install
```

How to run the report maker
----
```
ruby lib/report_maker.rb flight1.txt report1.txt
open report1.txt
ruby lib/report_maker.rb flight2.txt report2.txt
open report2.txt
```

How to run tests
----
```
rspec
```
and this is what you should see
![](public/image_to_come.png)