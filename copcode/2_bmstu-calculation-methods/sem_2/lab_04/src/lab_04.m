function lab_04()
    clc();

    a = -1;
    b = 0;
    delta = 1e-6;
    eps = 1e-4;

    debugFlag = true;
    delay = 0;

    fplot(@f, [a, b]);
    hold on;

    x = (a + b) / 2;
    f2_x0 = (f(x - delta) - 2 * f(x) + f(x + delta)) / power(delta, 2);
    N = 3;
    
    while true
        f1 = (f(x + delta) - f(x - delta)) / (2 * delta);
        N = N + 2;

        if debugFlag
            fprintf('N = %2d:   x = %.10f;   f1 = %.10f;\n\n', N, x, f1);
            plot(x, f(x), 'xk');
            pause(delay);
        end

        if abs(f1) < eps
            break;
        else
            x = x - f1 / f2_x0;
        end
    end

    x_star = x;
    f_star = f(x);
    N = N + 1;
    scatter(x_star, f_star, 'filled');
    fprintf('Ответ:   N = %2d;   x* = %.10f;   f(x*) = %.10f;\n\n', N, x_star, f_star);
    x_star + 0.777

    options = optimset('TolX', eps);
    if debugFlag
        options = optimset(options, 'Display', 'iter');
    end
    [x_star, f_star] = fminbnd(@f, a, b, options);
    fprintf('fminbnd:   x = %.10f;   f(x) = %.10f.\n\n', x_star, f_star);
end

function y = f(x)
y = (x+0.777).^4;    
%y = sin((power(x, 4) + 4 * power(x, 3)+8*power(x, 2) + 7 * x + 1)/sqrt(11)) - log10((4 * power(x, 5) - 4 * sqrt(10) * power(x, 4) + 8 * power(x, 3) + 5 * power(x, 2) - 5 * sqrt(10) * x + 9)/(power(x, 2) - sqrt(10) * x + 2)) - 1.0;
end
