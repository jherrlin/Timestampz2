# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  count = 1
  optionsForSelect1 = ""
  optionsForSelect2 = ""
  optionsForSelect3 = ""

  if gon.day_classes_1 != undefined
    optionsForSelect1 += "<option value='#{i.id}'>#{i.name}</option>" for i in gon.day_classes_1
  if gon.day_classes_2 != undefined
    optionsForSelect2 += "<option value='#{i.id}'>#{i.name}</option>" for i in gon.day_classes_2
  if gon.day_classes_3 != undefined
    optionsForSelect3 += "<option value='#{i.id}'>#{i.name}</option>" for i in gon.day_classes_3

  $('#add-student-form').on('click', ->
    $('#submit-button').before("<h4>Student</h4>")
    $('#submit-button').before("<input id='student_#{count}_first_name' type='text' placeholder='Enter First Name' name='student[#{count}][first_name]'>")
    $('#submit-button').before("<input id='student_#{count}_last_naLe' type='text' placeholder='Enter Last Name' name='student[#{count}][last_name]'><br>")
    $('#submit-button').before("<select id='student_#{count}_day_class_id' name='student[#{count}][day_class_id]'>
                                <option value=''>Select Class</option>#{optionsForSelect1}</select><br>")
    ) #end click
