From: Jean Delvare <khali@linux-fr.org>
Subject: [PATCH] radeonfb: prevent spurious recompilations
Date: Tue, 11 Oct 2005 21:55:07 +0200
Message-ID: <20051011215507.64e8aa40.khali@linux-fr.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPQf7-0008Q8-4T
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 Oct 2005 13:23:49 -0700
Received: from smtp-dmz-232-tuesday.dmz.nerim.net ([195.5.254.232] helo=kellthuzad.dmz.nerim.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EPQf4-0004xj-9q
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 11 Oct 2005 13:23:48 -0700
Received: from mallaury.nerim.net (smtp-102-tuesday.noc.nerim.net [62.4.17.102])
	by kellthuzad.dmz.nerim.net (Postfix) with ESMTP id D990139F61
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 11 Oct 2005 21:56:24 +0200 (CEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev-devel@lists.sourceforge.net

Hi Ben, all,

I'm doing frequent changes to the i2c header files, and noticed that
the radeonfb driver was recompiled each time I do, although I did not
include the I2C/DDC support. This is due to i2c header files being
included when they are not needed. Here is a patch fixing the problem.
Please consider applying it.

Thanks.


Prevent spurious recompilations of the radeonfb driver when I2C/DDC
support is not included and i2c header files are modified.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/video/aty/radeon_base.c |    1 -
 drivers/video/aty/radeonfb.h    |    3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.14-rc4.orig/drivers/video/aty/radeon_base.c	2005-10-11 21:37:22.000000000 +0200
+++ linux-2.6.14-rc4/drivers/video/aty/radeon_base.c	2005-10-11 21:37:44.000000000 +0200
@@ -69,7 +69,6 @@
 #include <linux/pci.h>
 #include <linux/vmalloc.h>
 #include <linux/device.h>
-#include <linux/i2c.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
--- linux-2.6.14-rc4.orig/drivers/video/aty/radeonfb.h	2005-10-01 11:01:06.000000000 +0200
+++ linux-2.6.14-rc4/drivers/video/aty/radeonfb.h	2005-10-11 21:41:46.000000000 +0200
@@ -10,9 +10,10 @@
 #include <linux/fb.h>
 
 
+#ifdef CONFIG_FB_RADEON_I2C
 #include <linux/i2c.h>
-#include <linux/i2c-id.h>
 #include <linux/i2c-algo-bit.h>
+#endif
 
 #include <asm/io.h>
 


-- 
Jean Delvare


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
