From: Kronos <kronos@kronoz.cjb.net>
Subject: Re: Re: New radeonfb, mostly untested
Date: Wed, 10 Sep 2003 18:41:01 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030910164101.GA437@dreamland.darkstar.lan>
References: <1062952639.655.6.camel@gaston> <20030907230334.GA847@dreamland.darkstar.lan> <1063000866.659.9.camel@gaston> <20030908190527.GA1731@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19x82i-0004Bu-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 09:42:08 -0700
Received: from mail-6.tiscali.it ([195.130.225.152])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19x82i-0006A7-7X
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Sep 2003 09:42:08 -0700
Content-Disposition: inline
In-Reply-To: <20030908190527.GA1731@dreamland.darkstar.lan>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Il Mon, Sep 08, 2003 at 09:05:27PM +0200, Kronos ha scritto: 
> We are in radeon_check_modes, just before it calls fb_find_mode:
> 
> radeonfb: mode_option: 1024x768-8@60
> radeonfb: has_default_mode = 0
> radeonfb: rinfo->mon1_dbsize 20
> radeonfb: calling fb_find_mode
> radeonfb: fb_find_mode -> 1
> radeonfb: rinfo->info.var.xres = 640, rinfo->info.var.yres = 480
> 
> fb_find_mode returns  1 (which should  mean that we are  using specified
> mode_option), but info.var is set to something else...
> I can't see what's going wrong here.

It  fails only  if  compiled  as module. I  see  that fb_find_mode  (and
my_atoi) are marked  as __init. Maybe they get discarded  after boot and
when  radeonfb module  tries  to call  them it  ends  up in  deallocated
memory...

When booting  with radeonfb  compiled in  the screen  is shifted  on the
left. At 1024x768 it is shifted by 2 characters:

hStart = 1048, hEnd = 1184, hTotal = 1344
vStart = 771, vEnd = 777, vTotal = 806
h_total_disp = 0x7f00a7 hsync_strt_wid = 0x910422
v_total_disp = 0x2ff0325 vsync_strt_wid = 0x860302
pixclock = 15384
freq = 6500
post div = 0x4
fb_div = 0x74
ppll_div_3 = 0x20074
Console: switching to colour frame buffer device 128x48

At 1280x768  (native res of my  LCD - now it  works) it is shifted  by 3
chars:

    Detailed Monitor Information
       108 MHz 1280 1328 1440 1688 1024 1025 1028 1066 +HSync +VSync

       Serial No     :  HD  001699
       Monitor Name  : Philips 170S4
       HorizSync     : 30-82 KHz
       VertRefresh   : 56-76 Hz
       Max Pixelclock: 140 MHz
 ========================================
ATI Radeon NE 9700 R300 SDR SGRAM 128 MB
hStart = 1359, hEnd = 1496, hTotal = 1713
vStart = 1025, vEnd = 1028, vTotal = 1060
h_total_disp = 0x9f00d5 hsync_strt_wid = 0x910559
v_total_disp = 0x3ff0423 vsync_strt_wid = 0x830400
pixclock = 9179
freq = 10894
post div = 0x2
fb_div = 0x61
ppll_div_3 = 0x10061
Console: switching to colour frame buffer device 160x64

This is very  annoying because I must re-center the  screen every time I
switch from  console to X and  viceversa. I had the same  issue with the
old driver + i2c code.

That doesn't happen with the standard modedb. At 1024x768 with
ignore_edid it's ok. At 1280x1024 it falls back to 800x600.

Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"I've seen things you people wouldn't believe...
 Attack Ships on fire off the shores of Orion.
 I've watched C-beams glitter in the dark off of Tanhauser Gate.
 All those moments will be lost in time...like tears, in rain.
 Time to die." -- Roy Batty (played by Rutger Hauer)


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
