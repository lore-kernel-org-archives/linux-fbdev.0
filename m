From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH] pnxrgbfb: Remove tty.h from #include
Date: Sun, 02 Jul 2006 11:43:05 +0800
Message-ID: <44A740C9.2060107@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fwsso-0006Bw-Nd for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 01 Jul 2006 20:44:30 -0700
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fwssn-0001vQ-52
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 01 Jul 2006 20:44:30 -0700
Received: by py-out-1112.google.com with SMTP id d42so1133150pyd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 01 Jul 2006 20:44:28 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Grigory Tolstolytkin <gtolstolytkin@ru.mvista.com>

Framebuffer drivers should have no dependencies on the tty layer.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 drivers/video/pnx4008/pnxrgbfb.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/video/pnx4008/pnxrgbfb.c b/drivers/video/pnx4008/pnxrgbfb.c
index 4bb7ad1..7d9453c 100644
--- a/drivers/video/pnx4008/pnxrgbfb.c
+++ b/drivers/video/pnx4008/pnxrgbfb.c
@@ -18,7 +18,6 @@ #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
 #include <linux/mm.h>
-#include <linux/tty.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/delay.h>


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
