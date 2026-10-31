String getRatingText(double rate) {
  switch (rate) {
    case (0.5 || 1):
      return 'very_poor';
    case (1.5 || 2):
      return 'poor';
    case (2.5 || 3):
      return 'fair';
   case (3.5 || 4):
      return 'good';
   case (4.5 || 5):
      return 'excellent';

    default:
     return '';
  }
}
