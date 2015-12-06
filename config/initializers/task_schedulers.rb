require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

scheduler.every("15s") do
  SupplierService.update_wines Supplier.all
end