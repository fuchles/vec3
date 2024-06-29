--vec3 library by fuchles


vec3 = {}
	
function vec3.getDistance(vec, vec1)
    local dir = vec3.subVec(vec1, vec)
    return vec3.length(dir)
end

function vec3.length(vec)
    return math.sqrt(vec.x^2 + vec.y^2 + vec.z^2)
end

function vec3.normalize(vec)
    return {x = vec.x/math.sqrt(vec.x^2 + vec.y^2 + vec.z^2), y = vec.y/math.sqrt(vec.x^2 + vec.y^2 + vec.z^2), z = vec.z/math.sqrt(vec.x^2 + vec.y^2 + vec.z^2)}
end

function vec3.getDirFromTo(vec, vec1)
    return vec3.normalize(vec3.toVec(vec1.x - vec.x, vec1.y - vec.y, vec1.z - vec.z))
end

function vec3.scaleVec(vector, scale)
    return {x = vector.x * scale, y = vector.y * scale, z = vector.z * scale}
end

function vec3.addVec(vec, vec1)
    return {x = vec.x+vec1.x, y = vec.y+vec1.y, z = vec.z+vec1.z}
end

function vec3.subVec(vec, vec1)
    return {x = vec.x - vec1.x, y = vec.y - vec1.y, z = vec.z - vec1.z}
end

function vec3.mulVec(vec, vec1)
    return {x = vec.x * vec1.x, y = vec.y * vec1.y, z = vec.z * vec1.z}
end

function vec3.dirToAngle(vec)
    local angle = math.atan2(vec.x, vec.y)
    local x = math.deg(math.atan2(vec.z, vec3.getDistance({x=vec.x,y=vec.y,z=0}, {x=0,y=0,z=0})))
    local z = -math.deg(angle)--180*angle/math.pi
    return {x = x, y = 0, z = z}
end

function vec3.crossVec(vec1, vec2)
    local result = {x,y,z}
    result.x = vec1.y * vec2.z - vec1.z * vec2.y;
    result.y = vec1.z * vec2.x - vec1.x * vec2.z;
    result.z = vec1.x * vec2.y - vec1.y * vec2.x;
    return result
end

function vec3.angleToDir(vec)
    local dx = math.sin(math.rad(vec.z))
    local dy = math.cos(math.rad(vec.z))
    local dz = math.tan(math.rad(vec.x))
    return {x = dx, y = dy, z = dz}
end

function vec3.toVec(px, py, pz)
    if not px then px = 0 end
    if not py then py = 0 end
    if not pz then pz = 0 end
    return {x = px, y = py, z = pz}
end

function vec3.getPos(element)
    local px, py, pz = getElementPosition(element)
    return {x = px, y = py, z = pz}
end

function vec3.getRot(element)
    local px, py, pz = getElementRotation(element)
    return {x = px, y = py, z = pz}
end

function vec3.planeRayIntersect(pos, normal, rayPos, rayDir)
    local d0 = -(normal.x*pos.x + normal.y*pos.y + normal.z*pos.z)

    local d = (normal.x*rayDir.x + normal.y*rayDir.y + normal.z*rayDir.z)
    if math.abs( d ) >= 0.00001 then
        local t = -(normal.x*rayPos.x + normal.y*rayPos.y + normal.z*rayPos.z + d0) / d
        if t >= 0 then
            return t
        end
    end

    return false
end

function vec3.getForward(element)
    local matrix = getElementMatrix(element)
    local vec = vec3.toVec(matrix[2][1], matrix[2][2], matrix[2][3])
    return vec
end

function vec3.getRight(element)
    local matrix = getElementMatrix(element)
    local vec = vec3.toVec(matrix[1][1], matrix[1][2], matrix[1][3])
    return vec
end

function vec3.getUp(element)
    local matrix = getElementMatrix(element)
    local vec = vec3.toVec(matrix[3][1], matrix[3][2], matrix[3][3])
    return vec
end
