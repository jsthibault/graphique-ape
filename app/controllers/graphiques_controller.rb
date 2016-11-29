require 'csv'
require 'json'

class GraphiquesController < ApplicationController
  public
    def tech3
      @url = request.original_fullpath;
      @url = @url.split('/').last;
      @_path = "./app/assets/csv/#{@url}/";
      @_indexTab = {
        :creditacquis => 3,
        :creditencours => 4,
        :creditobjectif => 5,
        :gpa => 1,
        :name => 0
      };
      @_error = "no error";
      @_arrayOfStudent = Array.new();
      #@tmp = Student.new("bob");
      #@_arrayOfStudent.push(@tmp);
      csvList = self.getCSVList(getPath());

      if (csvList.empty?)
        @_error = "No CSV read";
        exit
      end
      csvList.each { |value|
        self.csvTreatement(value);
      }
    end

    def cmpStudent(name)
      @_arrayOfStudent.each_with_index { |c, i|
        if (c.getName() == name)
          return (i);
        end
      }
      return (false);
    end

    def csvTreatement(csvName)
        statut = false

        puts("#{self.getPath()}#{csvName}");
        reader = CSV.read("#{self.getPath()}#{csvName}");
        reader.each_with_index { |value, index|
          if (index != 0)
            value.each_with_index { |stud, i|
              if (i == @_indexTab[:name])
                res = cmpStudent(stud);
                if (res == false)
                  @tmp = Student.new(stud);
                else
                  @tmp = @_arrayOfStudent[res];
                end
                @tmp.addDate(csvName);
                statut = true;
              elsif (i == @_indexTab[:gpa])
                @tmp.addGPA(stud);
              elsif (i == @_indexTab[:creditacquis])
                @tmp.addCreditAcquis(stud);
              elsif (i == @_indexTab[:creditencours])
                @tmp.addCreditEnCours(stud);
              elsif (i == @_indexTab[:creditobjectif])
                @tmp.addCreditObjectifs(stud);
              end
            }
            if (statut == true)
              statut = false
              @_arrayOfStudent.push(@tmp);
            end
          end
        }
    end


    def getCSVList(path)
      res = Dir.entries(path);
      csvList = Array.new();

      res.each { |value|
        if (value != "." && value != "..")
            csvList.push("#{value}");
        end
        }
        return(csvList.sort());
    end
    def getPath
      @_path;
    end

end

class Student
  public
    def initialize(name)
      @_name = name;
      @_creditAcquis = Array.new();
      @_creditEnCours = Array.new();
      @_creditObjectif = Array.new();
      @_gpa = Array.new();
      @_date = Array.new();
    end

    def getName
      @_name;
    end
    def getCrediAcquis
      @_creditAcquis;
    end
    def getCrediEnCours
      @_creditEnCours;
    end
    def getCrediObjectifs
      @_creditObjectif;
    end
    def getGPA
      @_gpa;
    end
    def getDate
      @_date;
    end

    def addCreditAcquis(value)
      @_creditAcquis.push(value);
    end
    def addCreditEnCours(value)
      @_creditEnCours.push(value);
    end
    def addCreditObjectifs(value)
      @_creditObjectif.push(value);
    end
    def addGPA(value)
      @_gpa.push(value);
    end
    def addDate(value)
      @_date.push(value);

    end

end
