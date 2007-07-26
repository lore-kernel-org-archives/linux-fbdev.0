From: "John Lumby" <johnlumby@hotmail.com>
Subject: Re: typo errors in the modedb.c video modetables
Date: Wed, 25 Jul 2007 23:16:00 -0400
Message-ID: <BAY137-F2532D5D8D314688B3874C0A3F20@phx.gbl>
References: <1185063967.8688.9.camel@daplas>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IDtph-00035P-KG for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Jul 2007 20:16:09 -0700
Received: from bay0-omc3-s8.bay0.hotmail.com ([65.54.246.208])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IDtpg-0003Th-AG
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Jul 2007 20:16:09 -0700
In-Reply-To: <1185063967.8688.9.camel@daplas>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@gmail.com

Antonino wrote :

>You can also avoid the table lookup and use 1400x1050M@60 instead.  The
>timings will be computed.

Thanks Antonio.    However, on my SuperSavage IX/C SDR rev 5 (a LCD), mode 
1400x1050M@60 results in a completely blank display.    mode 
11400x1050-32@60 gives me a barely-readable display (i.e. characters do 
appear) but with a shadow-zone  in the central columns of the display.

The only good display I have been able to achieve at this resolution was by 
hacking savagefb_driver.c and plugging in my own mode directly -
static struct fb_var_screeninfo __devinitdata savagefb_var1400x1050x32 = {
	.accel_flags =	FB_ACCELF_TEXT,
	.xres =		1400,
	.yres =		1050,
	.xres_virtual =  1400,
	.yres_virtual =  1050,
	.bits_per_pixel = 32,
	.pixclock =	9259,
	.left_margin =	136,
	.right_margin =	40,
	.upper_margin =	13,
	.lower_margin =	1,
	.hsync_len =	112,
	.vsync_len =	3,
	.sync =		0,
	.vmode =	FB_VMODE_NONINTERLACED
};
This worked almost ok - or rather, completely ok when running only the 
framebuffer consoles - but as soon as I started X, (XFree86),  and then 
VT-switching back to my framebuffer consoles - they had gone fuzzy and 
rippling.       Maybe because the XFree86 mode had a different refresh rate. 
      I also then tried to construct yet another explicit framebuffer mode 
to correspond to the XFree86 mode as displayed by xvidtune --show, but that 
also resulted in completely blank console display.

I would be interested to hear if anyone has been able to get high resolution 
(preferably 1400x1050 although I'd settle for 1280x1024 at this point) in 
the linux framebuffer console on a SuperSavage IX/C SDR rev 5 LCD  while X 
is running in virtual console 7.

John
>
>Tony
>

_________________________________________________________________
Tell us your tech love story in the Summer Lovin Competition for your chance 
to win laptop loaded with Windows Vista, Office 2007 and Windows Live 
OneCare. 
http://www.microsoft.com/canada/home/contests/summerlovin/default.aspx


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
