class Store

  attr_reader :name,
              :address,
              :type,
              :inventory_record

  def initialize(name, address, type)
    @name = name
    @address = address
    @type = type
    @inventory_record = []
  end

  def add_inventory(inventory)
    @inventory_record << inventory
  end

  def stock_check(item)
    inventories = find_inventories_with_item(item)
    inventory = sort_by_most_recent(inventories).first
    inventory.items[item]
  end

  def find_inventories_with_item(item)
    inventory_record.find_all do |inventory|
      inventory.items.keys.include?(item)
    end
  end

  def sort_by_most_recent(inventories)
    descend = -1
    inventories.sort_by do |inventory|
      descend * inventory.date.to_time.to_i
    end
  end

  def amount_sold(item)
    unsorted_inventories = find_inventories_with_item(item)
    inventories = sort_by_most_recent(unsorted_inventories)
    latest_data = inventories[0].items[item]
    previous_data = inventories[1].items[item]

    previous_data["quantity"] - latest_data["quantity"]
  end

end
