abstract class Discountable {
  double calculateDiscount(double price);
}

enum MembershipTier implements Discountable {
  regular(discountPercentage: 0.0, label: 'Regular Member'),
  gold(discountPercentage: 0.10, label: 'Gold Member'),
  vip(discountPercentage: 0.20, label: 'VIP Member');

  final double discountPercentage;
  final String label;

  const MembershipTier({
    required this.discountPercentage,
    required this.label,
  });

  @override
  double calculateDiscount(double price) {
    return price * discountPercentage;
  }
  double getFinalPrice(double originalPrice) {
    double discountAmount = calculateDiscount(originalPrice);
    return originalPrice - discountAmount;
  }
}

void main() {
  double originalPrice = 100.0;
  MembershipTier userTier = MembershipTier.vip;

  print('Tier: ${userTier.label}');
  print('Original Price: \$${originalPrice}');
  print('Discount: \$${userTier.calculateDiscount(originalPrice)}');
  print('Final Price: \$${userTier.getFinalPrice(originalPrice)}');
}