package com.photo

import grails.transaction.Transactional
import java.awt.AlphaComposite
import java.awt.Color
import java.awt.Graphics2D
import java.awt.geom.AffineTransform
import java.awt.geom.Rectangle2D
import java.awt.image.AffineTransformOp
import java.awt.image.BufferedImage
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream
import java.io.InputStream;

import javax.imageio.ImageIO
import org.springframework.web.multipart.commons.CommonsMultipartFile

@Transactional
class ImageService {

    boolean transactional = true

    def createImages(Picture picture, CommonsMultipartFile mpartData) {
        if (mpartData.isEmpty())
            return []

        BufferedImage original = ImageIO.read(mpartData.inputStream)
        def images = [
                new Image(picture: picture, size: Image.ORIGINAL),
                new Image(picture: picture, size: Image.SMALL),
                new Image(picture: picture, size: Image.MEDIUM),
                new Image(picture: picture, size: Image.LARGE)
        ]
        ByteArrayOutputStream output = new ByteArrayOutputStream(1024 * 1024)
        updateImages(images, original, output)
        images
    }

    private def updateImages(images, original, stream) {
        updateImage(images[Image.ORIGINAL], original, 'jpeg', stream)
        def large = resizeImage(original, dimensions(Image.LARGE), false)

        updateImage(images[Image.LARGE], large, 'png', stream)
        updateImage(images[Image.MEDIUM], resizeImage(large, dimensions(Image.MEDIUM), true), 'png', stream)
        updateImage(images[Image.SMALL], resizeImage(large, dimensions(Image.SMALL), true), 'png', stream)
    }

    private def updateImage(image, data, format, stream) {
        image.mimeType = "image/${format}"
        image.width = data.width
        image.height = data.height
        stream.reset()
        if (!ImageIO.write(data, format, stream)) {
            throw new IOException("Can't write the image in the given format '${format}'")
        }
        image.data = stream.toByteArray()
    }


    private static def dimensions(size) {
        [ Image.WIDTH[size], Image.HEIGHT[size] ]
    }

    private static def resizeImage(imageBuffer, dims, fit) {
        Integer width = dims[0]
        Integer height = dims[1]
        Integer imageWidth = imageBuffer.width
        Integer imageHeight = imageBuffer.height

        Double widthScale = (double)width / (double)imageWidth
        Double heightScale = (double)height / (double)imageHeight
        BufferedImage resizedImage = imageBuffer
        if (widthScale < 1.0d || heightScale < 1.0d) {
            Double scale = Math.min(widthScale, heightScale)
            def transform = new AffineTransform()
            transform.scale(scale, scale)
            def op = new AffineTransformOp(transform, AffineTransformOp.TYPE_BILINEAR)
            resizedImage = op.filter(imageBuffer, null)
            imageWidth = resizedImage.width
            imageHeight = resizedImage.height
        }

        if (fit && (imageWidth < width || imageHeight < height)) {
            BufferedImage fittedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB)
            Integer left = (width - imageWidth) / 2
            Integer top = (height - imageHeight) / 2
            Graphics2D graphics = fittedImage.createGraphics()
            graphics.setComposite(AlphaComposite.getInstance(AlphaComposite.CLEAR, 0.0f))
            graphics.fill(new Rectangle2D.Double(0, 0, width, height))
            graphics.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_OVER, 1.0f))
            graphics.drawImage(resizedImage, left, top, imageWidth, imageHeight, null)
            graphics.dispose()
            return fittedImage
        }
        resizedImage
    }

}
