From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: 2.6.1 fb.h patch for userland application
Date: Mon, 09 Feb 2004 11:44:43 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <4027649B.5010208@de.bosch.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aq8x9-0005jj-QK
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Feb 2004 02:47:47 -0800
Received: from gwa11.fe.bosch.de ([194.39.219.249])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Aq8x9-0005YQ-Af
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 09 Feb 2004 02:47:47 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: jsimmons@infradead.org, geert@linux-m68k.org

Hello,

I had problems to use linux/fb.h from 2.6.1 to compile userland 
application microwindows. I made some changes to get microwindows 0.90 
to compile, please see patch below.

The include files atomic.h and spinlock.h are necessary for spinlock_t 
and atomic_t. workqueue.h doesn't compile for userspace application and 
doesn't seem to be necessary at all (?). u8 is undefined while compiling 
for userspace, use __u8 instead.

Is this patch OK?

Dirk

--- linux/include/linux/fb.h_orig     2003-12-30 19:58:12.000000000 +0100
+++ linux/include/linux/fb.h        2004-02-04 10:11:59.000000000 +0100
@@ -2,8 +2,9 @@
  #define _LINUX_FB_H

  #include <linux/tty.h>
-#include <linux/workqueue.h>
+#include <linux/spinlock.h>
  #include <asm/types.h>
+#include <asm/atomic.h>
  #include <asm/io.h>

  /* Definitions of frame buffers 
          */
@@ -339,8 +340,8 @@ struct fb_pixmap {
         __u32 scan_align;                 /* alignment per scanline 
     */
         __u32 flags;                      /* see FB_PIXMAP_* 
     */
                                           /* access methods 
     */
-       void (*outbuf)(u8 *dst, u8 *addr, unsigned int size);
-       u8   (*inbuf) (u8 *addr);
+       void (*outbuf)(__u8 *dst, __u8 *addr, __u32 size);
+       __u8 (*inbuf) (__u8 *addr);
         spinlock_t lock;                  /* spinlock 
     */
         atomic_t count;
  };


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
