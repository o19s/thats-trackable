class SetAllToActive < ActiveRecord::Migration
  def change
    Runner.find_each { |runner| runner.update_attribute(:active, true) }

    names = ['Alaina Dimaria','Alex Allen','Allie Anness','Andria Li','Avery Patterson',
      'Caroline Koester','Caroline Outlaw','Causey Hope','Deborah Ayres-Brown',
      'Erica Grupp','Hana Lagana','Kelsey Tarleton','Kylie Heald','Molly Servine',
      'Nayiri Krysztofowicz','Nina Willms','Rebecca LaBelle','Riley Stackhouse','Ruby Neisser',
      'Sarah Inman','Sarah Servine','Shannon Durazo','Talley Johnston'
      ]

    names.each do |name|
      r = Runner.find_by_name(name)
      unless r.nil?
        r.active = false
        r.save!
      end
    end
  end
end
