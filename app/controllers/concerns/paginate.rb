module Paginate
  extend ActiveSupport::Concern
  include Kaminari::PageScopeMethods

  included do
    scope :sorte_update_desc, -> { order(updated_at: :desc) }
    scope :paginate6_update_desc, ->(p) { page(p[:page]).per(6).sorte_update_desc }
    scope :paginate5_update_descr, ->(p) { page(p[:page]).per(5).sorte_update_desc }
  end
end
