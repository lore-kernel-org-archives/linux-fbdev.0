From: Antonino Daplas <adaplas@pol.net>
Subject: Re: [PATCH 1/5]: logo fix
Date: 16 Feb 2003 19:12:59 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1045393909.1214.2.camel@localhost.localdomain>
References: <1045375680.1823.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pine.compass.com.ph ([202.70.96.37])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18kMjJ-0007FN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Feb 2003 03:13:05 -0800
In-Reply-To: <1045375680.1823.71.camel@localhost.localdomain>
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
To: Antonino Daplas <adaplas@pol.net>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-02-16 at 14:08, Antonino Daplas wrote:
> The attached patch (linux-2.5.61 + James' fbdev.diff) fixes the following:
> 
> 1. compile error because of missing scripts/pmntologo.  
> 
> 2. Break up of fb_show_logo() to fb_prepare_logo()/fb_show_logo() to fix
> weird "double drawing" or the "single draw, erase in a flash" of the
> logo.
> 
> 3. Fixed all drivers affected by the (image.depth == 0) is color
> expansion.
> 

Here's an incremental diff to protect logo drawing code with an
#ifdef CONFIG_FB_LOGO

Tony

diff -Naur linux-2.5.61-fbdev/drivers/video/fbmem.c linux-2.5.61-ad/drivers/video/fbmem.c
--- linux-2.5.61-fbdev/drivers/video/fbmem.c	2003-02-16 11:08:40.000000000 +0000
+++ linux-2.5.61-ad/drivers/video/fbmem.c	2003-02-16 11:08:19.000000000 +0000
@@ -41,7 +41,6 @@
 #include <asm/pgtable.h>
 
 #include <linux/fb.h>
-#include <linux/linux_logo.h>
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE
 #include "console/fbcon.h"
@@ -369,6 +368,9 @@
 	return n < 0 ? d >> -n : d << n;
 }
 
+#ifdef CONFIG_FB_LOGO
+#include <linux/linux_logo.h>
+
 static void __init fb_set_logocmap(struct fb_info *info,
 				   const struct linux_logo *logo)
 {
@@ -656,6 +658,10 @@
 		kfree(logo_new);
 	return fb_logo.logo->height;
 }
+#else
+int fb_prepare_logo(struct fb_info *info) { return 0; }
+int fb_show_logo(struct fb_info *info) { return 0; }
+#endif /* CONFIG_FB_LOGO */
 
 static int fbmem_read_proc(char *buf, char **start, off_t offset,
 			   int len, int *eof, void *private)



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
