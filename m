From: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Subject: Get console sem on fbdev ioctls
Date: Mon, 29 Mar 2004 16:45:55 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <041b01c415a4$ec018940$d100000a@sbs2003.local>
Reply-To: <benh@kernel.crashing.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7zb4-000532-2P
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Mar 2004 08:26:46 -0800
Received: from [194.202.64.57] (helo=smtp.paston.co.uk)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7zb2-00079e-Gn
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 29 Mar 2004 08:26:44 -0800
Received: from 2003SERVER.sbs2003.local (host213-123-250-229.in-addr.btopenworld.com [213.123.250.229])
	by smtp.paston.co.uk (Postfix) with ESMTP id 124D49B2A1
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 29 Mar 2004 17:29:52 +0100 (BST)
Content-Class: urn:content-classes:message
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Administrator@smtp.paston.co.uk
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>


Along with my VT race fixes I sent earlier, this is a patch (that may
need to be applied manually, I hacked the patch file a bit since my
tree is so different from yours at this point). It takes the console
semaphore on userland initiated mode change, pan display, ... ioctls.

Maybe more are required... This is the basics for at least fbset operations
to be "safe" (vs. printk/blanking and vs. the console resize code).

Note that with that and the VT fixes, I can properly now call vc_resize
instead of fbcon_resize in fbcon when getting a mode changed callback,
and that works really better.

I basically do that if cols and rows are seen to have changed:

	vc_resize(vc->vc_num, cols, rows);
	if (CON_IS_VISIBLE(vc)) {
		accel_clear_margins(vc, info, 0);
		update_screen(vc->vc_num);
	}

Though for stty to work fine, I also had to do proper mode selection/validation
for which I added this FB_ACTIVATE_FIND option (see my other email on the subject)
along with proper support in radeonfb.


diff -urN linux-2.5/drivers/video/fbmem.c linuxppc-2.5-benh/drivers/video/fbmem.c
--- linux-2.5/drivers/video/fbmem.c	2004-01-06 10:05:18.708660576 +1100
+++ linuxppc-2.5-benh/drivers/video/fbmem.c	2003-12-31 12:38:25.000000000 +1100
@@ -27,6 +27,7 @@
 #include <linux/init.h>
 #include <linux/linux_logo.h>
 #include <linux/proc_fs.h>
+#include <linux/console.h>
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
@@ -984,7 +995,9 @@
 	case FBIOPUT_VSCREENINFO:
 		if (copy_from_user(&var, (void *) arg, sizeof(var)))
 			return -EFAULT;
+		acquire_console_sem();
 		i = fb_set_var(info, &var);
+		release_console_sem();
 		if (i) return i;
 		if (copy_to_user((void *) arg, &var, sizeof(var)))
 			return -EFAULT;
@@ -1003,7 +1016,10 @@
 	case FBIOPAN_DISPLAY:
 		if (copy_from_user(&var, (void *) arg, sizeof(var)))
 			return -EFAULT;
-		if ((i = fb_pan_display(info, &var)))
+		acquire_console_sem();
+		i = fb_pan_display(info, &var);
+		release_console_sem();
+		if (i)
 			return i;
 		if (copy_to_user((void *) arg, &var, sizeof(var)))
 			return -EFAULT;
@@ -1039,7 +1055,10 @@
 		return 0;
 #endif	/* CONFIG_FRAMEBUFFER_CONSOLE */
 	case FBIOBLANK:
-		return fb_blank(info, arg);
+		acquire_console_sem();
+		i = fb_blank(info, arg);
+		release_console_sem();
+		return i;
 	default:
 		if (fb->fb_ioctl == NULL)
 			return -EINVAL;

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
