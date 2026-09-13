-- bullets.lua

function spawn_bullet()
    -- choose a random side
    local side=flr(rnd(4))

    local x
    local y
    local dx
    local dy

    -- top
    if side==0 then
        x=rnd(128)
        y=-4

        dx=(64-x)/100
        dy=1

    -- right
    elseif side==1 then
        x=132
        y=rnd(128)

        dx=-1
        dy=(64-y)/100

    -- bottom
    elseif side==2 then
        x=rnd(128)
        y=132

        dx=(64-x)/100
        dy=-1

    -- left
    else
        x=-4
        y=rnd(128)

        dx=1
        dy=(64-y)/100
    end

    add(bullets,{
        x=x,
        y=y,
        w=4,
        h=4,
        dx=dx,
        dy=dy
    })
end

function bullet_collision_check(b)
    local hit = b.x + b.w > player.x and b.x < player.x + player.w and b.y + b.h > player.y and b.y < player.y + player.h
    return hit -- right and left edges of bullet, then top and bottom edges of bullet
end

function update_bullets()
    for b in all(bullets) do

        if not b.stopped then
            -- move horizontally
            b.x+=b.dx

            -- move vertically
            b.y+=b.dy

            -- apply gravity
            b.dy+=gravity*gravity_dir
        end

        -- remove bullets outside the screen
        if b.x < -8 or b.x > 136 or
           b.y < -8 or b.y > 136 then

            del(bullets,b)
        -- detect if this bullet hit crush
        elseif death_timer == 0 and bullet_collision_check(b) then
            b.stopped=true
            death_timer = 30
            hit_flash_timer = 30
            -- will add sfx(0)
        end

    end
end


function draw_bullets()
    for b in all(bullets) do
        circfill(b.x,b.y,2,8)
    end
end