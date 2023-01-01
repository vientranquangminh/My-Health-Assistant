class DoctorObject {
  String id;
  String name;
  String department;
  String email;
  String dayOfBirth;
  String phone;
  String gender;
  DoctorObject(
      {required this.id,
      required this.name,
      required this.department,
      required this.email,
      required this.dayOfBirth,
      required this.phone,
      required this.gender});
}

List<DoctorObject> listDoctor = [
  DoctorObject(
      id: 'D01',
      name: 'Hoài Linh',
      department: 'General',
      email: 'linhxeom123@gmail.com',
      dayOfBirth: '12/10/2001',
      phone: '0905223344',
      gender: 'Male'),
  DoctorObject(
      id: 'D02',
      name: 'Đỗ Minh Thành',
      department: 'Dentist',
      email: 'dominhthanh0206@gmail.com',
      dayOfBirth: '02/06/2001',
      phone: '0905223344',
      gender: 'Female'),
];
