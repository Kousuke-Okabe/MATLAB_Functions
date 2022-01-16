function[R] = Rx(q,l)
    lx = l(1);
    ly = l(2);
    lz = l(3);
    R = [ 1,    0,          0,          lx  ;
          0,    cos(q),     -sin(q),    ly  ;
          0,    sin(q),     cos(q),     lz  ;
          0,    0,          0,          1   ];
end
