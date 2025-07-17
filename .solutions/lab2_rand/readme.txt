
There are three solutions in this directory for lab2:

- lab2run.f compiling packet_pkg.sv, packet_data.sv and packet_test.sv.
  Simple target and soure constraints

- lab2run1.f compiling packet_pkg1.sv, packet_data1.sv and packet_test1.sv.
  Conditional constraints on rand ptype for single, multicast and broadcast
  packets. Use of solve...before to control distribution. Broadcast packets not
  possible due to conflicting constraints

- lab2run2.f compiling packet_pkg2.sv, packet_data2.sv and packet_test2.sv.
  Fix to previous solution to allow broadcast packets by moving target and
  source constraint into conditional block.

