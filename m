From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH] sis: fix sparse warnings
Date: Wed, 16 Feb 2005 16:41:42 -0800
Message-ID: <20050216164142.4f30b90a.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1Zjo-0004Kb-DF
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 16:41:48 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D1Zjn-0006mf-TW
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Feb 2005 16:41:48 -0800
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
To: thomas@winischhofer.net, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net


sis_main.c needs linux/smp_lock.h;
also, fix one function return type.

drivers/video/sis/sis_main.c:2204:2: warning: undefined identifier 'lock_kernel'
drivers/video/sis/sis_main.c:2206:2: warning: undefined identifier 'unlock_kernel'
drivers/video/sis/sis_main.c:2204: warning: implicit declaration of function `lock_kernel'
drivers/video/sis/sis_main.c:2206: warning: implicit declaration of function `unlock_kernel'
drivers/video/sis/sis_main.c:2275:21: warning: incorrect type in initializer (different type sizes)
drivers/video/sis/sis_main.c:2275:21:    expected int [signed] ( *fb_compat_ioctl )( ... )
drivers/video/sis/sis_main.c:2275:21:    got long [signed] ( static [signed] [toplevel] *<noident> )( ... )
drivers/video/sis/sis_main.c:2275: warning: initialization from incompatible pointer type

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/video/sis/sis_main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -Naurp ./drivers/video/sis/sis_main.c~video_sis_includes ./drivers/video/sis/sis_main.c
--- ./drivers/video/sis/sis_main.c~video_sis_includes	2005-02-15 13:48:46.145337888 -0800
+++ ./drivers/video/sis/sis_main.c	2005-02-15 21:25:40.381740480 -0800
@@ -39,6 +39,7 @@
 #include <linux/moduleparam.h>
 #endif
 #include <linux/kernel.h>
+#include <linux/smp_lock.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -2198,7 +2199,7 @@ sisfb_ioctl(struct inode *inode, struct 
 }
 
 #ifdef CONFIG_COMPAT
-static long sisfb_compat_ioctl(struct file *f, unsigned cmd, unsigned long arg, struct fb_info *info)
+static int sisfb_compat_ioctl(struct file *f, unsigned cmd, unsigned long arg, struct fb_info *info)
 {
 	int ret;
 	lock_kernel();

---


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
