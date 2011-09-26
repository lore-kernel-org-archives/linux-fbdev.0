From: Timur Tabi <timur@freescale.com>
Date: Mon, 26 Sep 2011 20:55:45 +0000
Subject: Question on struct fb_videomode.name
Message-Id: <4E80E6D1.3010907@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

In my fb driver, I have an array of fb_videomode structs, like this:

static struct fb_videomode __devinitdata fsl_diu_mode_db[] = {
	{
		.name		= "1024x768-60",
		.refresh	= 60,
		.xres		= 1024,
		.yres		= 768,
		.pixclock	= 15385,
		.left_margin	= 160,
		.right_margin	= 24,
		.upper_margin	= 29,
		.lower_margin	= 3,
		.hsync_len	= 136,
		.vsync_len	= 6,
		.sync		= FB_SYNC_COMP_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
		.vmode		= FB_VMODE_NONINTERLACED
	},
	...

Is there any value in specifying the .name field as "<xres>x<yres>-<ref>"?  I
know the .name field is optional, but what happens if I don't specify it?  It
just seems redundant to generate the name based on other data in the same structure.

-- 
Timur Tabi
Linux kernel developer at Freescale

