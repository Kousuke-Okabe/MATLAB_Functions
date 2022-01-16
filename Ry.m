function[R] = Ry(q,l)
    lx = l(1);
    ly = l(2);
    lz = l(3);
    
    R = [ cos(q),   0,      sin(q),     lx  ;
          0,        1,      0,          ly  ;
          -sin(q),  0,      cos(q),     lz  ;
          0,        0,      0,          1   ];
end
