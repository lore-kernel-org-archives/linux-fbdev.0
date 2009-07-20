From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH v2 3/2] ep93xx video driver
	documentation
Date: Tue, 21 Jul 2009 09:31:41 +1200
Message-ID: <4A64E23D.9060007@bluewatersys.com>
References: <4A60D6F3.5060906@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ryan@bluewatersys.com>) id 1MT0RB-0000pp-C1
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Jul 2009 21:30:21 +0000
Received: from mail.bluewatersys.com ([202.124.120.130]
	helo=hayes.bluewaternz.com)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MT0R3-0002dL-RT
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Jul 2009 21:30:21 +0000
In-Reply-To: <4A60D6F3.5060906@bluewatersys.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, hartleys <hartleys@visionengravers.com>, d.venzano@motronica.com

Documentation for the ep93xx LCD controller

Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
---

diff --git a/Documentation/fb/ep93xx_fb.txt b/Documentation/fb/ep93xx_fb.txt
new file mode 100644
index 0000000..f77e6c4
--- /dev/null
+++ b/Documentation/fb/ep93xx_fb.txt
@@ -0,0 +1,105 @@
+================================
+Driver for EP93xx LCD controller
+================================
+
+The EP93xx LCD controller can drive both standard desktop monitors and
+embedded LCD displays. If you have a standard desktop monitor then you
+can use the standard Linux video mode database. In your board file:
+
+	static struct ep93xxfb_mach_info some_board_fb_info = {
+		.num_modes	= EP93XXFB_USE_MODEDB,
+		.bpp		= 16,
+	};
+
+If you have an embedded LCD display then you need to define a video
+mode for it as follows:
+
+	static struct fb_videomode some_board_video_modes[] = {
+		{
+			.name		= "some_lcd_name",
+			/* Pixel clock, porches, etc */
+		},
+	};
+
+	static struct ep93xxfb_mach_info some_board_fb_info = {
+		.num_modes	= ARRAY_SIZE(some_board_video_modes),
+		.modes		= some_board_video_modes,
+		.default_mode	= &some_board_video_modes[0],
+		.bpp		= 16,
+	};
+
+The framebuffer device can be registered by adding the following to
+your board initialisation function:
+
+	ep93xx_register_fb(&some_board_fb_info);
+
+=====================
+Video Attribute Flags
+=====================
+
+The ep93xxfb_mach_info structure has a flags field which can be used
+to configure the controller. The video attributes flags are fully
+documented in section 7 of the EP93xx users' guide. The following
+flags are available:
+
+EP93XXFB_PCLK_FALLING		Clock data on the falling edge of the
+				pixel clock. The default is to clock
+				data on the rising edge.
+
+EP93XXFB_SYNC_BLANK_HIGH	Blank signal is active high. By
+				default the blank signal is active low.
+
+EP93XXFB_SYNC_HORIZ_HIGH	Horizontal sync is active high. By
+				default the horizontal sync is active low.
+
+EP93XXFB_SYNC_VERT_HIGH		Vertical sync is active high. By
+				default the vertical sync is active high.
+
+The physical address of the framebuffer can be controlled using the
+following flags:
+
+EP93XXFB_USE_SDCSN0		Use SDCSn[0] for the framebuffer. This
+				is the default setting.
+
+EP93XXFB_USE_SDCSN1		Use SDCSn[1] for the framebuffer. 
+
+EP93XXFB_USE_SDCSN2		Use SDCSn[2] for the framebuffer. 
+
+EP93XXFB_USE_SDCSN3		Use SDCSn[3] for the framebuffer.
+
+======================
+Setting the video mode
+======================
+
+The video mode is set using the following syntax:
+
+	video=XRESxYRES[-BPP][@REFRESH]
+
+If the EP93xx video driver is built-in then the video mode is set on
+the Linux kernel command line, for example:
+
+	video=800x600-16@60
+
+If the EP93xx video driver is built as a module then the video mode is
+set when the module is installed:
+
+	modprobe ep93xx_fb video=320x240
+
+==============
+Screenpage bug
+==============
+
+At least on the EP9315 there is a silicon bug which causes bit 27 of
+the VIDSCRNPAGE (framebuffer physical offset) to be tied low. There is
+an unofficial errata for this bug at: 
+	http://marc.info/?l=linux-arm-kernel&m=110061245502000&w=2
+
+By default the EP93xx framebuffer driver checks if the allocated physical
+address has bit 27 set. If it does, then the memory is freed and an
+error is returned. The check can be disabled by adding the following
+option when loading the driver:
+
+      ep93xx_fb.check_screenpage_bug=0
+
+In some cases it may be possible to reconfigure your SDRAM layout to
+avoid this bug. See section 13 of the EP93xx users' guide for details.


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
