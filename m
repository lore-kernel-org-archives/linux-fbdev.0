From: Ico Doornekamp <fbdev@zevv.nl>
Subject: Xorg dies on my deferred I/O fb driver
Date: Wed, 17 Dec 2008 15:01:41 +0100
Message-ID: <20081217140141.GL12994@pruts.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ico@pruts.nl>) id 1LCwyH-0006ka-10
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 14:01:53 +0000
Received: from pruts.nl ([82.94.235.106] helo=iron.pruts.nl)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LCwyD-0008Ds-0A for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 17 Dec 2008 14:01:52 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by iron.pruts.nl (Postfix) with ESMTP id 97AA912E445
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 17 Dec 2008 15:01:46 +0100 (CET)
Received: from iron.pruts.nl ([127.0.0.1])
	by localhost (iron.pruts.nl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rOFlurI8Yqld
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 17 Dec 2008 15:01:41 +0100 (CET)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net


Hello,

Today I wrote a simple framebuffer driver for a SPI driven LCD display
with internal memory, using the deferred I/O framework. The display is
capable of grayscale, 384x160 pixels.

My driver resembles the metronomefb driver, and seems to work using
write() and mmap() with my own test tools.

The next step would be to run Xorg/fbdev on top, but things don't seem
to simple work this way.

Xorg starts and detects te framebuffer driver, but dies with the message

  (EE) FBDEV(0): FBIOPUT_VSCREENINFO succeeded but modified mode
  (EE) FBDEV(0): mode initialization failed

I'm kind of stuck here. Any tips on how to solve or debug this one ?

On the bottom of this mail I pasted:

- fbinfo -i output
- Xorg log
- fb_fix_screeninfoa and fb_var_screeninfo from my driver

Running Xorg 1.4.2 on Linux 2.6.27.4

Thank you,

Ico


P.S. Jaya, thanks for your lecture at CELF a few weeks ago!


----------------------------------------------------------------------
# fbinfo -i

mode "384x160"
    geometry 384 160 384 160 8
    timings 0 0 0 0 0 0 0
    grayscale true
    rgba 0/0,0/0,0/0,0/0
endmode

Frame buffer device information:
    Name        : uc1698fb
    Address     : 0
    Size        : 61440
    Type        : PACKED PIXELS
    Visual      : STATIC PSEUDOCOLOR
    XPanStep    : 0
    YPanStep    : 0
    YWrapStep   : 0
    LineLength  : 384
    Accelerator : No

----------------------------------------------------------------------
Xorg.0.log

(II) FBDEV(0): Creating default Display subsection in Screen section
        "Default Screen" for depth/fbbpp 8/8
(==) FBDEV(0): Depth 8, (==) framebuffer bpp 8
(==) FBDEV(0): Default visual is PseudoColor
(==) FBDEV(0): Using gamma correction (1.0, 1.0, 1.0)
(II) FBDEV(0): hardware: uc1698fb (video memory: 60kB)
(**) FBDEV(0): Option "ShadowFB" "false"
(II) FBDEV(0): checking modes against framebuffer device...
(II) FBDEV(0): checking modes against monitor...
(--) FBDEV(0): Virtual size is 384x160 (pitch 384)
(**) FBDEV(0):  Built-in mode "current"
(==) FBDEV(0): DPI set to (96, 96)
(II) Loading sub module "fb"
(II) LoadModule: "fb"
(II) Loading /usr/lib/xorg/modules//libfb.so
(II) Module fb: vendor="X.Org Foundation"
        compiled for 1.4.2, module version = 1.0.0
        ABI class: X.Org ANSI C Emulation, version 0.3
(EE) FBDEV(0): FBIOPUT_VSCREENINFO succeeded but modified mode
(EE) FBDEV(0): mode initialization failed


----------------------------------------------------------------------
FB setup data structures from driver

tatic struct fb_fix_screeninfo uc1698fb_fix __devinitdata = {
        .id =           "uc1698fb",
        .type =         FB_TYPE_PACKED_PIXELS,
        .visual =       FB_VISUAL_STATIC_PSEUDOCOLOR,
        .xpanstep =     0,
        .ypanstep =     0,
        .ywrapstep =    0,
        .line_length =  DPY_W,
        .accel =        FB_ACCEL_NONE,
};

static struct fb_var_screeninfo uc1698fb_var __devinitdata = {
        .xres           = DPY_W,
        .yres           = DPY_H,
        .xres_virtual   = DPY_W,
        .yres_virtual   = DPY_H,
        .bits_per_pixel = 8,
        .grayscale      = 1,
        .nonstd         = 0,

};


-- 
:wq
^X^Cy^K^X^C^C^C^C

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
