function MyPareto = Pareto_Front_Extractor_TwoArrays(column1,column2)

f1=column1;
f2=column2; 

ip = true(size(f1));

for k=1:numel(f1)
    if any(f1<f1(k)&(f2<=f2(k)))
        ip(k) = false;
    end
    
    
    if any(f2<f2(k)&(f1<=f1(k)))
        ip(k) = false;
    
    end
    
end

MyPareto = ip;

end
