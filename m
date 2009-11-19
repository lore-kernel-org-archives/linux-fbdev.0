From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: i810fb: fix wrong pixclock for discrete mode
	selection
Date: Thu, 19 Nov 2009 18:58:01 +0100
Message-ID: <20091119185801.467fbaf8.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1NBBFY-0000ru-R4
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Nov 2009 17:56:56 +0000
Received: from smtp240.poczta.interia.pl ([217.74.64.240])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NBBFR-0000as-Ff for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 19 Nov 2009 17:56:56 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

If the i810fb driver is configured for use only predefined discrete video modes
the wrong pixclock value is used. The par->regs.pixclock value is a value from
the previous mode when a video mode is switched. It results in unreadable screen
if the old video mode has higher resolution and the new mode with the old (high)
pixclock is outside attached monitor's specs.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
I have noticed this testing the patch named "i810fb: Fix stack exploding".

This patch requires my patch send to Alan Cox and Andrew Morton 
named "i810fb: Fix stack exploding".

--- drivers/video/i810/i810_dvt.c~	2009-11-17 19:38:11.002864450 +0100
+++ drivers/video/i810/i810_dvt.c	2009-11-19 18:48:52.518846238 +0100
@@ -233,7 +233,7 @@ static int i810fb_find_best_mode(u32 xre
 void i810fb_encode_registers(const struct fb_var_screeninfo *var,
 			     struct i810fb_par *par, u32 xres, u32 yres)
 {
-	u32 i_best = i810fb_find_best_mode(xres, yres, par->regs.pixclock);
+	u32 i_best = i810fb_find_best_mode(xres, yres, var->pixclock);
 
 	par->regs = std_modes[i_best];
 

----------------------------------------------------------------------
Najlepsze oferty Sylwestrowe!
Sprawdz >>> http://link.interia.pl/f2426


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
