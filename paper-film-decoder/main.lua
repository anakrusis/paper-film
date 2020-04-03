-- PAPER FILM DECODER

require "camera"

function love.load()
	imgName = "output2.png"
	imgWidth = 1080
	imgHeight = 1080
	
	offsetX = 0
	offsetY = 0
	
	framesWidth = 5
	framesHeight = 6
	
	startFrame = 1
	endFrame = startFrame + (framesWidth * framesHeight) - 1

	marginSize = 16
	inputImage = love.image.newImageData(imgName)
	displayImage = love.graphics.newImage(inputImage)

end

function love.keypressed(key)
	if key == "r" then
	
		canvas = love.image.newImageData(imgWidth, imgHeight)
		for i = startFrame, endFrame do
			currentImgName = string.format("%04d", i) .. ".png"
			
			hpos = (i-1) % framesHeight
			vpos = math.floor( (i-1) / framesHeight)

			canvas:paste(inputImage, 0, 0, (vpos * imgHeight) + offsetX, (hpos * imgWidth) + offsetY, imgWidth, imgHeight)
			
			canvas:encode("png", currentImgName)
		end
	end
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
	
	-- origin adjusment
	if love.keyboard.isDown("up") then
		offsetY = offsetY - speedmodifier
	elseif love.keyboard.isDown("down") then
		offsetY = offsetY + speedmodifier
	end
	if love.keyboard.isDown("left") then
		offsetX = offsetX - speedmodifier
	elseif love.keyboard.isDown("right") then
		offsetX = offsetX + speedmodifier
	end
	
	-- image size
	if love.keyboard.isDown("q") then
		imgHeight = imgHeight + speedmodifier
		imgWidth = imgWidth + speedmodifier
	elseif love.keyboard.isDown("e") then
		imgHeight = imgHeight - speedmodifier
		imgWidth = imgWidth - speedmodifier
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
	if displayImage ~= nil then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(displayImage,tra_x(0),tra_y(0),0,cam_zoom,cam_zoom)
		
		love.graphics.setColor(1,0,0)
		
		for i = startFrame, endFrame do
		
			hpos = (i-1) % framesHeight
			vpos = math.floor( (i-1) / framesHeight)
			love.graphics.rectangle("line", tra_x((vpos * imgHeight) + offsetX), tra_y((hpos * imgWidth) + offsetY), imgWidth * cam_zoom, imgHeight * cam_zoom)
		end
		
	end
end