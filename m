From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] offb: use framebuffer_alloc() to
	allocate fb_info struct
Date: Mon, 4 May 2009 19:07:24 +0200
Message-ID: <20090504190724.c2dfb53c.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1M11Z4-0003vg-8X
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 17:02:50 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M11Z3-0005Yw-0d for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 04 May 2009 17:02:50 +0000
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
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Use the framebuffer_alloc() function to allocate the fb_info
structure so the structure is correctly initialized after allocation.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

diff -urp linux-orig/drivers/video/offb.c linux-2.6.30/drivers/video/offb.c
--- linux-orig/drivers/video/offb.c	2008-08-09 05:09:05.000000000 +0200
+++ linux-2.6.30/drivers/video/offb.c	2009-05-04 00:14:28.000000000 +0200
@@ -378,7 +378,6 @@ static void __init offb_init_fb(const ch
 	struct fb_fix_screeninfo *fix;
 	struct fb_var_screeninfo *var;
 	struct fb_info *info;
-	int size;
 
 	if (!request_mem_region(res_start, res_size, "offb"))
 		return;
@@ -393,15 +392,12 @@ static void __init offb_init_fb(const ch
 		return;
 	}
 
-	size = sizeof(struct fb_info) + sizeof(u32) * 16;
-
-	info = kmalloc(size, GFP_ATOMIC);
+	info = framebuffer_alloc(sizeof(u32) * 16, NULL);
 	
 	if (info == 0) {
 		release_mem_region(res_start, res_size);
 		return;
 	}
-	memset(info, 0, size);
 
 	fix = &info->fix;
 	var = &info->var;

----------------------------------------------------------------------
Wygraj 3000 zl, wycieczke lub lot balonem!
Sprawdz >> http://link.interia.pl/f2154


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
