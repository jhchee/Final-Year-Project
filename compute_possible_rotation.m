% Compute rotation mapping indices available for the specified dimension
% (set by bit length)


disp(strcat("Running '", mfilename, "' ..."));
load('config.mat');
load(strcat("data/rotation_indices/", "cube-", num2str(bit_len), "_rotation_indices.mat"));

% start with some mapping
initial_mapping = [0:1:num_genotype-1];

r_spec_dimension = repelem({{}}, bit_len-2);
r_times = {[1,2,3], [1,3]};
r_counter = 0;

% specify the number of times that each rotation should be performed
% count from the first bit to second last (left -> right)
for bit_position = 1:bit_len-2 
    % Number of rotation performed with respect to the current dimension.
    % This is current bit position (current dimension) - 1.
    % e.g. with 4D rotation, we can rotate along 1st, 2nd and 3rd axis 
    % w.r.t the 4th axis, hence the number of rotation w.r.t the current 
    % axis will be 3.
    % This is bit length - current bit position, since we count the 
    % bit from the left.
    num_rotation_dimension = bit_len - bit_position;
    
    % iterate through rotation w.r.t to the current dimension indicated by
    % bit position
    for j = 1:num_rotation_dimension
        % counter to iterate through the rotation list
        r_counter = r_counter + 1;
        
        % We can interpret the rotation with respect to the current 
        % dimension as positioning the hyperface in any possible locations
        % it can be at.
        
        % Twice of any rotation (of the same respective dimension) always
        % result hyperface at the same spot. Hence, only one of the 
        % rotation performed w.r.t the dimension is performed twice, which
        % we specify this to be always the first
        % You can try this with a rubiks cube, select a face that you
        % want to observe, rotating it twice along the x axis will 
        % result the same position as rotating it twice along the y axis
        
        if j==1 % rotating once, twice and thrice for the first rotation w.r.t the current dimension
            for k = 1:length(r_times{1})
                r_spec_dimension{bit_position}{end+1} = repelem([r_counter], r_times{1}(k));
            end
        else % rotating once and thrice for the rest
            for k = 1:length(r_times{2})
                r_spec_dimension{bit_position}{end+1} = repelem([r_counter], r_times{2}(k));
            end
        end      
    end
end

% Perform the actual rotation with the rotation specification computed
% above. This will yield a list of possible rotation available for
% the genotypic structure. The rotation will be performed until the 3rd
% dimension. The 2D rotation will be performed later. 
% At this stage, we are displacing the hyperface at any location it can be.

% Store rotation mapping at each of round of rotation (performed at each
% dimension).
m = repelem({{}}, bit_len-1);
% The initial mapping represents the first round of rotation.
m{1} = initial_mapping;

for bit_position = 1:bit_len-2 % stop before 2nd dimension 
    num_rotation_dimension = length(r_spec_dimension{bit_position});
    m{bit_position+1} = [];
    
     % loop through mapping of previous dimension rotation
    for j = 1:size(m{bit_position},1)
        current_mapping = m{bit_position}(j,:); % append the unaltered mapping
        m{bit_position+1} = [[m{bit_position+1}]; current_mapping];
        
        % rotate the current mapping (more like slotting the hyperface into
        % different location)
        for k = 1:num_rotation_dimension % loop through rotation available for current dimension
            m{bit_position+1} = ...
                [ [m{bit_position+1}];
                  rotation_operator(r_spec_dimension{bit_position}{k},current_mapping)
                ];
        end
    end
end


m{end+1} = [];
counter = 1;

% In 3-cube, we have 6 hyperfaces.
% The previous round of rotation positions the 6 different (hyper)faces 
% location. Now, we are rotating each mapping once, twice and thrice with
% specified axis.
% 1: rotation along 3rd bit axis
% 2: rotation along 2nd bit axis
% 3: rotation along 1st bit axis
% rotation along 3rd bit axis will be performed at slot 1,3
% rotation along 2nd bit axis will be performed at slot 2,4
% rotation along 1st bit axis will be performed at slot 5,6
final_rotation = [3,2,3,2,1,1] + (size(rotation_mapping_indices,1)-3); % add offset
%                 1,2,3,4,5,6 faces

% loop through the previous round of dimension mapping, apply the final round of
% rotation (2D rotation)
for bit_position = 1:size(m{end-1},1)
    m{end} = [m{end}; m{end-1}(bit_position,:)];
    type_rotation = final_rotation(counter);
    
    for  j = 1:3 % perform the specified rotation 3 times
         m{end} = [[m{end}]; rotation_operator(repelem([type_rotation],j), m{end-1}(bit_position,:))];
    end
    
    counter = counter + 1;
    if counter == 7
        counter = 1;
    end 
end

foldername = "data/possible_rotation/";
filename = strcat(foldername, "cube-", num2str(bit_len),  "_possible_rotation.mat");
if ~exist(foldername, 'dir')
       mkdir(foldername)
end
m{end}(1,:) = []; % remove initial mapping
possible_rotation = m{end};
save(filename, 'possible_rotation');