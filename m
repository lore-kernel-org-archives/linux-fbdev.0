From: Richard Zidlicky <rz@linux-m68k.org>
Subject: Oops in fbcon_setup
Date: Sat, 31 Aug 2002 22:20:01 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20020831222000.A205@linux-m68k.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102])
	by usw-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 17lF73-0001Bb-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 31 Aug 2002 13:44:58 -0700
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi,

I came around testing q40fb.c, fbcon_setup oopses because
apparently dispsw isn't set anywhere.

This patch seems to fix it although I had very little opportunity 
to test much further (it was good enough to display the next Oops
though ;)

--- linux-m68k-2.5.x/drivers/video/q40fb.c      Tue Aug 13 21:30:36 2002
+++ build-2.5/drivers/video/q40fb.c     Sat Aug 31 14:33:11 2002
@@ -29,6 +29,7 @@
 #include <asm/pgtable.h>
 
 #include <video/fbcon.h>
+#include <video/fbcon-cfb16.h>
 
 #define Q40_PHYS_SCREEN_ADDR 0xFE800000
 
@@ -125,6 +126,8 @@
        fb_info.switch_con      = gen_switch;
        fb_info.updatevar       = gen_update_var;
        fb_alloc_cmap(&fb_info.cmap, 16, 0);
+
+       display.dispsw = &fbcon_cfb16;
 
         gen_set_disp(-1, &fb_info);
 

Richard


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
