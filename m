From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: New radeonfb, mostly untested
Date: Wed, 10 Sep 2003 18:48:26 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1063212505.642.77.camel@gaston>
References: <1062952639.655.6.camel@gaston>
	 <20030907230334.GA847@dreamland.darkstar.lan>
	 <1063000866.659.9.camel@gaston>
	 <20030908190527.GA1731@dreamland.darkstar.lan>
	 <20030910164101.GA437@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19x8fP-0000EE-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 10:22:07 -0700
Received: from panoramix.vasoftware.com
	([198.186.202.147] helo=externalmx.vasoftware.com ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19x8fO-0004rP-Md
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 10 Sep 2003 10:22:06 -0700
Received: from pentafluge.infradead.org ([213.86.99.235]:39951)
	by externalmx.vasoftware.com with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 4.22 #1 (Debian))
	id 19x898-0006BX-IL
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 10 Sep 2003 09:48:47 -0700
In-Reply-To: <20030910164101.GA437@dreamland.darkstar.lan>
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
To: Kronos <kronos@kronoz.cjb.net>
Cc: Jon Smirl <jonsmirl@yahoo.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> It  fails only  if  compiled  as module. I  see  that fb_find_mode  (and
> my_atoi) are marked  as __init. Maybe they get discarded  after boot and
> when  radeonfb module  tries  to call  them it  ends  up in  deallocated
> memory...

Exactly, they should definitely not be marked __init

> When booting  with radeonfb  compiled in  the screen  is shifted  on the
> left. At 1024x768 it is shifted by 2 characters:
> 
> hStart = 1048, hEnd = 1184, hTotal = 1344
> vStart = 771, vEnd = 777, vTotal = 806
> h_total_disp = 0x7f00a7 hsync_strt_wid = 0x910422
> v_total_disp = 0x2ff0325 vsync_strt_wid = 0x860302
> pixclock = 15384
> freq = 6500
> post div = 0x4
> fb_div = 0x74
> ppll_div_3 = 0x20074
> Console: switching to colour frame buffer device 128x48
> 
> At 1280x768  (native res of my  LCD - now it  works) it is shifted  by 3
> chars:
> 
>     Detailed Monitor Information
>        108 MHz 1280 1328 1440 1688 1024 1025 1028 1066 +HSync +VSync
> 
>        Serial No     :  HD  001699
>        Monitor Name  : Philips 170S4
>        HorizSync     : 30-82 KHz
>        VertRefresh   : 56-76 Hz
>        Max Pixelclock: 140 MHz
>  ========================================
> ATI Radeon NE 9700 R300 SDR SGRAM 128 MB
> hStart = 1359, hEnd = 1496, hTotal = 1713
> vStart = 1025, vEnd = 1028, vTotal = 1060
> h_total_disp = 0x9f00d5 hsync_strt_wid = 0x910559
> v_total_disp = 0x3ff0423 vsync_strt_wid = 0x830400
> pixclock = 9179
> freq = 10894
> post div = 0x2
> fb_div = 0x61
> ppll_div_3 = 0x10061
> Console: switching to colour frame buffer device 160x64
> 
> This is very  annoying because I must re-center the  screen every time I
> switch from  console to X and  viceversa. I had the same  issue with the
> old driver + i2c code.
> 
> That doesn't happen with the standard modedb. At 1024x768 with
> ignore_edid it's ok. At 1280x1024 it falls back to 800x600.

Can you try tweaking the hSync and vSync polarity ?

Ben.
 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
