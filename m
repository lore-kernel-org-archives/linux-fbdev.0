From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Subject: s13d...fb fill_rect accel giving wrong color
Date: Mon, 20 Apr 2009 20:22:43 +0200
Message-ID: <20090420202243.d1ad7cee.kristoffer.ericson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <kristoffer.ericson@gmail.com>) id 1Lvy4i-0000ru-Po
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Apr 2009 18:18:36 +0000
Received: from mail-fx0-f177.google.com ([209.85.220.177])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Lvy4Z-0005U6-JK for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Apr 2009 18:18:36 +0000
Received: by fxm25 with SMTP id 25so2194111fxm.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 20 Apr 2009 11:18:25 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>

Greetings,

My accelerated fill_rect is working nicely apart from the fact that its
giving me the wrong colors. For instance mc has its empty spaces
being black when they should be blue.Its doesnt show up
in pure console but thats probably since its generally black :)

Ive added some debugging code to both cfb_fillrect and my routine
and its accessing the same pseudo_palette[x] color.

cfb_fillrect uses pixel_to_pat() to get its color value. I havent
completely understod whats the purpose of it. I cannot push
an 32bit value into my color registers since its only 16bit.

So any pointers would be great!

Best wishes
Kristoffer

debug_logs :
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[1] = 21
s1d13xxxfb_bitblt_solidfill : dx=32, dy=24, stride=1280, dest=30784
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[3] = 1365
s1d13xxxfb_bitblt_solidfill : dx=32, dy=24, stride=1280, dest=30784
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[1] = 21
s1d13xxxfb_bitblt_solidfill : dx=32, dy=24, stride=1280, dest=30784
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[3] = 1365
s1d13xxxfb_bitblt_solidfill : dx=32, dy=24, stride=1280, dest=30784
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[1] = 21
s1d13xxxfb_bitblt_solidfill : dx=32, dy=24, stride=1280, dest=30784
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[3] = 1365
s1d13xxxfb_bitblt_solidfill : dx=32, dy=24, stride=1280, dest=30784
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[1] = 21
s1d13xxxfb_bitblt_solidfill : dx=32, dy=24, stride=1280, dest=30784
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[3] = 1365
s1d13xxxfb_bitblt_solidfill : dx=32, dy=24, stride=1280, dest=30784
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[1] = 21
s1d13xxxfb_bitblt_solidfill : dx=352, dy=24, stride=1280, dest=31424
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[3] = 1365
s1d13xxxfb_bitblt_solidfill : dx=352, dy=24, stride=1280, dest=31424
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[1] = 21
s1d13xxxfb_bitblt_solidfill : dx=352, dy=24, stride=1280, dest=31424
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[3] = 1365
s1d13xxxfb_bitblt_solidfill : dx=352, dy=24, stride=1280, dest=31424
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[1] = 21
s1d13xxxfb_bitblt_solidfill : dx=352, dy=24, stride=1280, dest=31424
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[3] = 1365
s1d13xxxfb_bitblt_solidfill : dx=352, dy=24, stride=1280, dest=31424
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[1] = 21
s1d13xxxfb_bitblt_solidfill : dx=352, dy=24, stride=1280, dest=31424
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[3] = 1365
s1d13xxxfb_bitblt_solidfill : dx=352, dy=24, stride=1280, dest=31424
s1d13xxxfb_bitblt_solidfill : rect_width=111, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[1] = 21
s1d13xxxfb_bitblt_solidfill : dx=88, dy=64, stride=1280, dest=82096
s1d13xxxfb_bitblt_solidfill : rect_width=463, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[7] = 44373
s1d13xxxfb_bitblt_solidfill : dx=104, dy=88, stride=1280, dest=112848
s1d13xxxfb_bitblt_solidfill : rect_width=431, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[7] = 44373
s1d13xxxfb_bitblt_solidfill : dx=104, dy=96, stride=1280, dest=123088
s1d13xxxfb_bitblt_solidfill : rect_width=151, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[7] = 44373
s1d13xxxfb_bitblt_solidfill : dx=376, dy=96, stride=1280, dest=123632
s1d13xxxfb_bitblt_solidfill : rect_width=159, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[7] = 44373
s1d13xxxfb_bitblt_solidfill : dx=88, dy=112, stride=1280, dest=143536
s1d13xxxfb_bitblt_solidfill : rect_width=463, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[7] = 44373
s1d13xxxfb_bitblt_solidfill : dx=0, dy=0, stride=1280, dest=0
s1d13xxxfb_bitblt_solidfill : rect_width=639, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[0] = 0
s1d13xxxfb_bitblt_solidfill : dx=0, dy=8, stride=1280, dest=10240
s1d13xxxfb_bitblt_solidfill : rect_width=639, rect_height=231
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[0] = 0
s1d13xxxfb_bitblt_solidfill : dx=0, dy=232, stride=1280, dest=296960
s1d13xxxfb_bitblt_solidfill : rect_width=639, rect_height=7
s1d13xxxfb_bitblt_solidfill : xres=640, yres=240, bpp=16
s1d13xxxfb_bitblt_solidfill : ROP=0
s1d13xxxfb_bitblt_solidfill : TRUECOLOR/DIRECTCOLOR
s1d13xxxfb_bitblt_solidfill : pseudo_palette[0] = 0

cfb_fillrect : TRUECOLOR/DIRECTCOLOR
cfb_fillrect : pseudo_palette[0] = 0
cfb_fillrect : bpp=16, width=640, height=232
cfb_fillrect : pat=0
cfb_fillrect : TRUECOLOR/DIRECTCOLOR
cfb_fillrect : pseudo_palette[3] = 1365
cfb_fillrect : bpp=16, width=248, height=8
cfb_fillrect : pat=89458005
cfb_fillrect : TRUECOLOR/DIRECTCOLOR
cfb_fillrect : pseudo_palette[1] = 21
cfb_fillrect : bpp=16, width=112, height=8
cfb_fillrect : pat=1376277
cfb_fillrect : TRUECOLOR/DIRECTCOLOR
cfb_fillrect : pseudo_palette[3] = 1365
cfb_fillrect : bpp=16, width=112, height=8
cfb_fillrect : pat=89458005
cfb_fillrect : TRUECOLOR/DIRECTCOLOR
cfb_fillrect : pseudo_palette[1] = 21
cfb_fillrect : bpp=16, width=280, height=8
cfb_fillrect : pat=1376277
cfb_fillrect : TRUECOLOR/DIRECTCOLOR
cfb_fillrect : pseudo_palette[1] = 21
cfb_fillrect : bpp=16, width=280, height=8
cfb_fillrect : pat=1376277
cfb_fillrect : TRUECOLOR/DIRECTCOLOR
cfb_fillrect : pseudo_palette[1] = 21
cfb_fillrect : bpp=16, width=112, height=8
cfb_fillrect : pat=1376277
cfb_fillrect : TRUECOLOR/DIRECTCOLOR
cfb_fillrect : pseudo_palette[3] = 1365
cfb_fillrect : bpp=16, width=112, height=8
cfb_fillrect : pat=89458005
cfb_fillrect : TRUECOLOR/DIRECTCOLOR
cfb_fillrect : pseudo_palette[1] = 21
cfb_fillrect : bpp=16, width=112, height=8
cfb_fillrect : pat=1376277
cfb_fillrect : TRUECOLOR/DIRECTCOLOR
cfb_fillrect : pseudo_palette[3] = 1365
cfb_fillrect : bpp=16, width=112, height=8
cfb_fillrect : pat=89458005
cfb_fillrect : TRUECOLOR/DIRECTCOLOR
cfb_fillrect : pseudo_palette[0] = 0
cfb_fillrect : bpp=16, width=640, height=240
cfb_fillrect : pat=0





-- 
Kristoffer Ericson <kristoffer.ericson@gmail.com>

------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
