module Spree
  Order.class_eval do

    before_validation :update_shipping_address_from_ups
    validate :shipping_address_is_valid_via_ups

    private

      def update_shipping_address_from_ups
        ship_address.update_address_from_ups
      end

      def shipping_address_is_valid_via_ups
        if ship_address.ups_response.no_candidates?
          errors.add(:base, Spree.t(:ups_address_invalid))
        elsif ship_address.ups_response.ambiguous?
          errors.add(:base, Spree.t(:ups_address_ambiguous))
        end
      end
  end
end