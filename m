From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 26 May 2010 14:09:58 +0000
Subject: Idea of a v4l -> fb interface driver
Message-Id: <Pine.LNX.4.64.1005261559390.22516@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This message has been earlier sent to the V4L mailing list

Linux Media Mailing List <linux-media@vger.kernel.org>

When replying, please add it to CC. This is a discussion proposal for the 
V4L mini summit, that is going to take place in June in Helsinki, Finland. 
Any opinions very welcome.

		V4L(2) video output vs. framebuffer.

Problem: Currently the standard way to provide graphical output on various 
(embedded) displays like LCDs is to use a framebuffer driver. The 
interface is well supported and widely adopted in the user-space, many 
applications, including the X-server, various libraries like directfb, 
gstreamer, mplayer, etc. In the kernel space, however, the subsystem has a 
number of problems. It is unmaintained. The infrastructure is not being 
further developed, every specific hardware driver is being supported by 
the respective architecture community. But as video output hardware 
evolves, more complex displays and buses appear and have to be supported, 
the subsystem shows its aging. For example, there is currently no way to 
write reusable across multiple platforms display drivers.

OTOH V4L2 has a standard video output driver support, it is not very 
widely used, in the userspace I know only of gstreamer, that somehow 
supports video-output v4l2 devices in latest versions. But, being a part 
of the v4l2 subsystem, these drivers already now can take a full advantage 
of all v4l2 APIs, including the v4l2-subdev API for the driver reuse.

So, how can we help graphics driver developers on the one hand by 
providing them with a capable driver framework (v4l2) and on the other 
hand by simplifying the task of interfacing to the user-space?

How about a v4l2-output - fbdev translation layer? You write a v4l2-output 
driver and get a framebuffer device free of charge... TBH, I haven't given 
this too much of a thought, but so far I don't see anything that would 
make this impossible in principle. The video buffer management is quite 
different between the two systems, but maybe we can teach video-output 
drivers to work with just one buffer too? Anyway, feel free to tell me why 
this is an absolutely impossible / impractical idea;)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
