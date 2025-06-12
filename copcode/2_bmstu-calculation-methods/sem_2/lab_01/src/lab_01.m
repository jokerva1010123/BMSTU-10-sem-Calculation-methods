function lab_01()
    clc();

    debugFlg = true;
    delay = 0;
    a = -1;
    b = 0;
    eps = 0.000001;

    fplot(@f, [a, b]);
    hold on;
    
    [xStar, fStar] = bitwiseSearch(a, b, eps, debugFlg, delay);
    scatter(xStar, fStar, 'r', 'filled');
end

function [x0, f0] = bitwiseSearch(a, b, eps, debugFlg, delay)
    i = 1;
    x0 = a;
    f0 = f(x0);
    delta = (b - a) / 4;
    
    if debugFlg
        fprintf('N = %2d:   x0 = %.10f;   f(x0) = %.10f;\n', i, x0, f0);
    end
    
    plot_x = [];
    plot_f = [];
    while true
        i = i + 1;
        x1 = x0 + delta;
        f1 = f(x1);

        if debugFlg
            fprintf('N = %2d:   x1 = %.10f;   f(x1) = %.10f;\n', i, x1, f1);

            plot_x(end + 1) = x1;
            plot_f(end + 1) = f1;
            
            plot(plot_x, plot_f, '*k');
            plot(x1, f1, '*r');
   
            pause(delay);
        end

        if f0 > f1
            if x1 <= a || x1 >= b
                if abs(delta) < eps
                    break;
                else
                    delta = - delta / 4;
                end
            end
            
            x0 = x1;
            f0 = f1;
        else
            if abs(delta) < eps
                break;
            else
                delta = - delta / 4;
            end
            
            x0 = x1;
            f0 = f1;
        end
    end
    
    fprintf('\nОтвет:   x* = %.10f;   f(x*) = %.10f.\n', x0, f0);
    
    if debugFlg
        plot(plot_x, plot_f, '*k');
    end
end

function y = f(x)
    y = sin((power(x, 4) + 4 * power(x, 3)+8*power(x, 2) + 7 * x + 1)/sqrt(11)) - log10((4 * power(x, 5) - 4 * sqrt(10) * power(x, 4) + 8 * power(x, 3) + 5 * power(x, 2) - 5 * sqrt(10) * x + 9)/(power(x, 2) - sqrt(10) * x + 2)) - 1.0;
end
