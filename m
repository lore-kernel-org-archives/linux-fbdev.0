From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] staging: misplaced parentheses?
Date: Fri, 15 May 2009 12:51:43 +0200
Message-ID: <4A0D493F.5010509@gmail.com>
References: <4A0C0C4E.6070401@gmail.com>	
	<20090514093827.33a099f7.akpm@linux-foundation.org>
	<1242343459.1867.27.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <roel.kluin@gmail.com>) id 1M4v1z-0004kE-73
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 15 May 2009 10:52:47 +0000
Received: from ey-out-1920.google.com ([74.125.78.145])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M4v11-0007Im-1I for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 15 May 2009 10:52:47 +0000
Received: by ey-out-1920.google.com with SMTP id 13so468475eye.4
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 15 May 2009 03:51:45 -0700 (PDT)
In-Reply-To: <1242343459.1867.27.camel@pasglop>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, adaplas@gmail.com

The leftmost `+' has a higher precedence than the `?' so this returns
(vres * (hres * (1 << color_mode) + (VMODE && CMODE) ? 0x10 : 0x20) + 0x1000

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---

> Yes, the original code looks ok and the patches one not quite ...

Ok, my former patch may have been wrong, but unless I am very much
mistaken, there is something fishy here.

> The idea is that the framebuffer is offset by 0x1020 normally, except
> when the video mode is VMODE_832_624_75 and the depth > 8 in which case
> it's offet by 0x1010. It's a weird piece of HW but I think the original
> code is correct. Or do I miss something ?

Thanks for this, let's simplify to explain what I think that goes wrong:

printf("%d\n", 1 + 0 ? 2 : 4);

This prints `2': since the `+' operator has a higher precedence than the
trinary `?' operator.

In the original code we had:

return vmode_attrs[video_mode-1].vres *
  	       (vmode_attrs[video_mode-1].hres * (1<<color_mode) +
  		((video_mode == VMODE_832_624_75) &&
		 (color_mode > CMODE_8)) ? 0x10 : 0x20) + 0x1000;

note that `hres * (1<<color_mode)' is added to
((video_mode == VMODE_832_624_75) && (color_mode > CMODE_8))
before the trinary operator `?' occurs.

So maybe instead of the first patch you may want to apply this?

diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
index 03b3670..2cc986f 100644
--- a/drivers/video/platinumfb.c
+++ b/drivers/video/platinumfb.c
@@ -224,7 +224,7 @@ static inline int platinum_vram_reqd(int video_mode, int color_mode)
 	return vmode_attrs[video_mode-1].vres *
 	       (vmode_attrs[video_mode-1].hres * (1<<color_mode) +
 		((video_mode == VMODE_832_624_75) &&
-		 (color_mode > CMODE_8)) ? 0x10 : 0x20) + 0x1000;
+		 (color_mode > CMODE_8) ? 0x1010 : 0x1020));
 }
 
 #define STORE_D2(a, d) { \

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
