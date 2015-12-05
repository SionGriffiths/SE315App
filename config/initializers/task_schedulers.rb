require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

scheduler.every("5m") do
  SupplierService.update_wines Supplier.all
end