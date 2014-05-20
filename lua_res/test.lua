local gift_set = require("gift_set")
local item_container = require("item_container")

function add_sum_weight(item_container)
    for i=1, #(item_container.all_type) do
        local sum_weight = 0
        for j=1, #(item_container.all_type[i]) do
            sum_weight = sum_weight + item_container.all_type[i][j].item_weight  
        end
        item_container.all_type[i].sum_weight = sum_weight
    end
end

add_sum_weight(item_container)

math.randomseed(os.time())

function lottery(gift_set)
    local lottery_items = {}
    for i=1, #(gift_set.all_type) do
        for j=1, #(gift_set.all_type[i]) do
            local rand_num = math.random(100)
            print("item_container[" .. gift_set.all_type[i][j].item_container_id ..
                "] rand_num = " .. rand_num .. ", weight = " .. gift_set.all_type[i][j].item_container_weight)
            if rand_num <= gift_set.all_type[i][j].item_container_weight then
                print("\tget item_container[" .. gift_set.all_type[i][j].item_container_id .. "]")
                local item_container_name = item_container.type_map[gift_set.all_type[i][j].item_container_id]
                local cur_item_container = item_container[item_container_name]
                local rand_num = math.random(cur_item_container.sum_weight)
                print("\titem_container[" .. gift_set.all_type[i][j].item_container_id ..
                    "] rand_num = " .. rand_num .. ", sum_weight = " .. cur_item_container.sum_weight)
                local sum_item_weight = 0
                for k=1, #(cur_item_container) do
                    print("\t\titem_id[" .. cur_item_container[k].item_id ..
                        "] item_weight[" .. cur_item_container[k].item_weight .. "]")
                    sum_item_weight = sum_item_weight + cur_item_container[k].item_weight
                    print("\t\tsum_item_weight[" .. sum_item_weight .. "]")
                    if rand_num <= sum_item_weight then
                        print("\t\tget item[" .. cur_item_container[k].item_id .. "]")
                        table.insert(lottery_items, cur_item_container[k].item_id)
                        break 
                    end
                end
            end
        end
    end
    return lottery_items
end

local lottery_items = lottery(gift_set)
for i=1, #lottery_items do
    print(lottery_items[i])
end

