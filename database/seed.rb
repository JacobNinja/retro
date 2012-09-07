require File.expand_path('./../connection', __FILE__)

DB[:users].insert(name: "test", password: "123", figure: "1150120723280013050122525", sex: "M", mission: "mission")