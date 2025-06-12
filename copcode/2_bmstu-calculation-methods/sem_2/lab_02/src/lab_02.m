function lab_02()
    clc();

    a = -1;
    b = 0;
    eps = 1e-6;

    debugFlag = true;
    delay = 0.5;

    fplot(@f, [a, b]);
    hold on;

    tau = (sqrt(5) - 1) / 2;
    l = b - a;

    x1 = b - tau * l;
    x2 = a + tau * l;
    f1 = f(x1);
    f2 = f(x2);

    N = 2;
    while true
        if debugFlag
            fprintf('N = %2d:   a = %.10f;   b = %.10f;\n', N, a, b);
            line([a b], [f(a) f(b)]);
            pause(delay);
        end

        if l > 2 * eps
            if f1 <= f2
                b = x2;
                l = b - a;

                x2 = x1;
                f2 = f1;

                x1 = b - tau * l;
                f1 = f(x1);
            else
                a = x1;
                l = b - a;

                x1 = x2;
                f1 = f2;

                x2 = a + tau * l;
                f2 = f(x2);
            end

            N = N + 1;
        else
            xStar = (a + b) / 2;
            fStar= f(xStar);

            N = N + 1;
            break
        end
    end

    scatter(xStar, fStar, 'r', 'filled');
    fprintf('\nОтвет:   N = %2d;   x* = %.10f;   f(x*) = %.10f.\n\n', N, xStar, fStar);
end

function y = f(x)
    y = sin((power(x, 4) + 4 * power(x, 3)+8*power(x, 2) + 7 * x + 1)/sqrt(11)) - log10((4 * power(x, 5) - 4 * sqrt(10) * power(x, 4) + 8 * power(x, 3) + 5 * power(x, 2) - 5 * sqrt(10) * x + 9)/(power(x, 2) - sqrt(10) * x + 2)) - 1.0;
end
