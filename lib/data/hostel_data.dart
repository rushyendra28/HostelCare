import '../models/hostel.dart';

List<Hostel> globalHostels = [
  Hostel(
    id: '1',
    name: 'Sunrise Hostel',
    location: 'Mumbai',
    rating: 4.5,
    reviews: 234,
    about:
        'A modern and well-maintained hostel with excellent facilities. Our hostel provides a safe and comfortable living environment for students and professionals.',
    amenities: ['Free WiFi', 'Meals', '24/7 Security', 'Common Area'],
    isJoined: false,
  ),
  Hostel(
    id: '2',
    name: 'Green Valley Residence',
    location: 'Bangalore',
    rating: 4.8,
    reviews: 456,
    about: 'Premium hostel with modern amenities and dedicated support.',
    amenities: ['Free WiFi', 'Meals', '24/7 Security', 'Common Area', 'Gym'],
    isJoined: false,
  ),
  Hostel(
    id: '3',
    name: 'Ocean View Hostel',
    location: 'Goa',
    rating: 4.3,
    reviews: 189,
    about: 'Beach-side hostel with stunning views and peaceful environment.',
    amenities: ['Free WiFi', 'Meals', '24/7 Security'],
    isJoined: false,
  ),
];
