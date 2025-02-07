function [output1, output2] = function_test(input1)
    
    vector_length = length(input1);
    

   temp_max = 0;
    for i1 = 1:1:vector_length

        if(temp_max <= input1(i1))
            output1 = input1(i1);
            output2 = i1;

        end

    end


end