clear;
clc;
X=load('hw2_lssvm_all.txt');
for i=1:size(X,2)-1
    D(:,i)=X(:,i);
end
Y=X(:,size(X,2));
clear X;
data_size=400;
val_size=size(Y,1)-data_size;
train_data=D(1:data_size,:);
train_y=Y(1:data_size);
val_data=D(data_size+1:size(D,1),:);
val_y=Y(data_size+1:size(D,1));
r=32;
for m=1:3
    lada=0.001;
    for l=1:3
        lada=lada;
        % kernle matrix
        for i=1:data_size
            for j=1:data_size
                distance=norm(train_data(i,:)-train_data(j,:))^2;
                K(i,j)=exp(-r*distance);
            end
        end
        belta=(lada*eye(data_size)+K)*train_y;
        w=belta'*train_data;

        %cal Ein
        err=0;
        for i=1:data_size
            out=sign(w*train_data(i,:)');
            if out ~= train_y(i)
                err=err+1;
            end
        end
        err=err/data_size
        %cal Eout
        err=0;
        for i=1:val_size
            out=sign(w*val_data(i,:)');
            if out ~= val_y(i)
                err=err+1;
            end
        end
        err=err/val_size;
        lada=lada*1000;
    end
   r=r/16;
end    
    
