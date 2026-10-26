function[R] = R(q,l)
    lx = l(1);
    ly = l(2);
    R = [ cos(q),   -sin(q),    lx  ;
          sin(q),   cos(q),     ly  ;
          0,        0,          1   ];
end
