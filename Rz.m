function[R] = Rz(q,l)
    lx = l(1);
    ly = l(2);
    lz = l(3);
    R = [ cos(q),   -sin(q),    0,  lx  ;
          sin(q),   cos(q),     0,  ly  ;
          0,        0,          1,  lz  ;
          0,        0,          0,  1   ];
end
