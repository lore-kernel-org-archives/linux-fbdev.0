From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 04 Jun 2010 15:27:15 +0000
Subject: HDMI timing parameters problem
Message-Id: <Pine.LNX.4.64.1006041332020.19386@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi all

I'm trying to configure an HDMI controller on an ARM based SoC, and I 
cannot seem to find suitable values for blanking parameters.

The monitor EDID reports 1280x1024@108MHz:

H_ACTIVE = 1280
H_SYNC_OFFSET = 48
H_SYNC_WIDTH = 112
H_BLANKING = 408

V_ACTIVE = 1024
V_SYNC_OFFSET = 1
V_SYNC_WIDTH = 3
V_BLANKING = 42

The HDMI controller can be programmed in one of two modes: with a preset 
configuration or manually specifying each parameter. The only mode that 
somehow works up to now is the preset 1280x720@74.25MHz. With this mode 
the image on the monitor is stretched vertically, but it works. 
Unfortunately, the controller doesn't have any preset modes for 1280x1024 
or for anything close enough. So, I have to support manual geometry 
configuration. To reduce the number of required changes, as a first step, 
I'm trying to achieve the same result in manual mode, as I've got with 
preset, by programming 1280x720. For this I've chosen the following 
configuration:

	.xres = 1280,
	.yres = 720,
	.left_margin = 224,
	.right_margin = 104,
	.hsync_len = 40,
	.upper_margin = 20,
	.lower_margin = 5,
	.vsync_len = 5,

which is the same, as what I'm configuring my LCD controller 
with. This translates to

H_ACTIVE = 1280
H_SYNC_OFFSET = 104
H_SYNC_WIDTH = 40
H_BLANKING = 368

V_ACTIVE = 720
V_SYNC_OFFSET = 5
V_SYNC_WIDTH = 5
V_BLANKING = 30

With it the monitor recognises the signal, the LED goes green, but there's 
no image.

I've done a few more tests with various configurations, but so far with no 
success. Can anyone suggest how to debug this? How to find the proper 
video mode?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
