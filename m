From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: v2.4.21 vesafb oddity (fwd)
Date: Fri, 27 Jun 2003 10:29:26 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0306271029160.2794-100000@vervain.sonytel.be>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19VocQ-0004ba-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 27 Jun 2003 01:30:06 -0700
Received: from vervain.sonytel.be (localhost [127.0.0.1])
	by witte.sonytel.be (8.12.9/8.12.9) with ESMTP id h5R8TPpI005964
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 27 Jun 2003 10:29:26 +0200 (MEST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

---------- Forwarded message ----------
Date: Fri, 27 Jun 2003 14:17:14 +0600 (GMT-6)
From: ishan_jayawardena@yahoo.co.uk
To: geert@linux-m68k.org
Cc: alan@lxorguk.ukuu.org.uk
Subject: v2.4.21 vesafb oddity


Greetings,

Thanks for taking the time to read this.
At least for the VESAFB driver in 2.4.21, the framebuffer size is being 
miscalculated. This yields wildly different values with different modes.
e.g. (The memory on the card is 2M)

--- fbdmesg-2.4.21	Fri Jun 27 00:01:53 2003
+++ fbdmesg-2.4.21-ac2	Fri Jun 27 00:08:52 2003

 . . .

-vesafb: framebuffer at 0xf4000000, mapped to 0xc4800000, size 12288k
+vesafb: framebuffer at 0xf4000000, mapped to 0xc4800000, size 2048k
 vesafb: mode is 1024x768x16, linelength=2048, pages=0
 vesafb: protected mode interface info at c000:5db2

 . . .

In mode 791 (1024x768x16bpp) the stock kernel reports 12288k, while the 
-ac kernel correctly reports 2048k. In lower modes (800x600x16bpp etc.) 
both kernels report values less than 2048k (1875k, etc.). The patch below 
reverts this back to the v2.2 behaviour.
I'm afraid I just don't know the time at which this anomaly began, except 
that 2.4.20 (-acN and stock) was fine.

--- linux/drivers/video/vesafb.c.1	Fri Jun 27 00:18:25 2003
+++ linux/drivers/video/vesafb.c	Fri Jun 27 00:27:29 2003
@@ -520,7 +520,7 @@ int __init vesafb_init(void)
 	video_width         = screen_info.lfb_width;
 	video_height        = screen_info.lfb_height;
 	video_linelength    = screen_info.lfb_linelength;
-	video_size          = screen_info.lfb_width *	screen_info.lfb_height * video_bpp;
+	video_size          = screen_info.lfb_size * 65536;
 	video_visual = (video_bpp == 8) ?
 		FB_VISUAL_PSEUDOCOLOR : FB_VISUAL_TRUECOLOR;
 

-- 
"Lies, lies, all is lies! Yet beyond I tell you, beauteous and eternal
stands the Truth, Macumazahn."
 - Zikali






-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
