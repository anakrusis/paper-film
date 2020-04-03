-- PAPER FILM ENCODER

require "camera"

function love.load()
	imgName = "spicy"
	imgWidth = 1080
	imgHeight = 1080
	
	framesWidth = 5
	framesHeight = 6
	startFrame = 1
	endFrame = startFrame + (framesWidth * framesHeight) - 1
	
	marginSize = 16
	
	data = love.image.newImageData(imgWidth * framesWidth + (marginSize * framesWidth),imgHeight * framesHeight + (marginSize * framesHeight))
	
	for i = startFrame, endFrame do
		currentImgName = "in/" .. imgName .. string.format("%04d", i) .. ".png"
		print(currentImgName)
		image = love.image.newImageData(currentImgName)
		if image ~= null then
		
			hpos = (i-1) % framesHeight
			vpos = math.floor( (i-1) / framesHeight)
		
			marginH = marginSize * hpos
			marginV = marginSize * vpos
			
			data:paste( image, vpos * imgHeight + marginV, hpos * imgWidth + marginH, 0, 0, imgWidth, imgHeight)
		end
	end	
	
	outputImage = love.graphics.newImage(data)
	data:encode("png","output.png")
end

function love.update(dt)
	if love.keyboard.isDown("w") then
		cam_y = cam_y - cam_speed*speedmodifier
	elseif love.keyboard.isDown("s") then
		cam_y = cam_y + cam_speed*speedmodifier
	end
	if love.keyboard.isDown("a") then
		cam_x = cam_x - cam_speed*speedmodifier
	elseif love.keyboard.isDown("d") then
		cam_x = cam_x + cam_speed*speedmodifier
	end
	
	if love.keyboard.isDown("lshift") then
		speedmodifier = 10
	else
		speedmodifier = 1
	end
end

function love.wheelmoved(x, y)
	if y > 0 then
		cam_zoom = cam_zoom + cam_zoomspeed
	elseif y < 0 then
		cam_zoom = cam_zoom - cam_zoomspeed
	end
end

function love.draw()
	if outputImage ~= nil then
		love.graphics.draw(outputImage,tra_x(0),tra_y(0),0,cam_zoom,cam_zoom)
	end
end